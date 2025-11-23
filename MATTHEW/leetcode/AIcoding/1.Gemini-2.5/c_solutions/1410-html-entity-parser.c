#include <stdlib.h>
#include <string.h>

char* entityParser(char* text) {
    int text_len = strlen(text);
    char* temp_buffer = (char*)malloc(text_len + 1);

    int text_idx = 0;
    int temp_idx = 0;

    while (text_idx < text_len) {
        if (text_idx + 4 < text_len &&
            text[text_idx] == '&' &&
            text[text_idx+1] == 'a' &&
            text[text_idx+2] == 'm' &&
            text[text_idx+3] == 'p' &&
            text[text_idx+4] == ';') {

            temp_buffer[temp_idx++] = '&';
            text_idx += 5;
        } else {
            temp_buffer[temp_idx++] = text[text_idx++];
        }
    }
    temp_buffer[temp_idx] = '\0';

    int temp_len = strlen(temp_buffer);
    char* result_buffer = (char*)malloc(temp_len + 1);

    int result_idx = 0;
    temp_idx = 0;

    while (temp_idx < temp_len) {
        if (temp_buffer[temp_idx] == '&') {
            if (temp_idx + 6 < temp_len &&
                temp_buffer[temp_idx+1] == 'f' && temp_buffer[temp_idx+2] == 'r' &&
                temp_buffer[temp_idx+3] == 'a' && temp_buffer[temp_idx+4] == 's' &&
                temp_buffer[temp_idx+5] == 'l' && temp_buffer[temp_idx+6] == ';') {

                result_buffer[result_idx++] = '/';
                temp_idx += 7;
            } 
            else if (temp_idx + 5 < temp_len &&
                     temp_buffer[temp_idx+1] == 'q' && temp_buffer[temp_idx+2] == 'u' &&
                     temp_buffer[temp_idx+3] == 'o' && temp_buffer[temp_idx+4] == 't' &&
                     temp_buffer[temp_idx+5] == ';') {

                result_buffer[result_idx++] = '"';
                temp_idx += 6;
            }
            else if (temp_idx + 5 < temp_len &&
                     temp_buffer[temp_idx+1] == 'a' && temp_buffer[temp_idx+2] == 'p' &&
                     temp_buffer[temp_idx+3] == 'o' && temp_buffer[temp_idx+4] == 's' &&
                     temp_buffer[temp_idx+5] == ';') {

                result_buffer[result_idx++] = '\'';
                temp_idx += 6;
            }
            else if (temp_idx + 3 < temp_len &&
                     temp_buffer[temp_idx+1] == 'g' && temp_buffer[temp_idx+2] == 't' &&
                     temp_buffer[temp_idx+3] == ';') {

                result_buffer[result_idx++] = '>';
                temp_idx += 4;
            }
            else if (temp_idx + 3 < temp_len &&
                     temp_buffer[temp_idx+1] == 'l' && temp_buffer[temp_idx+2] == 't' &&
                     temp_buffer[temp_idx+3] == ';') {

                result_buffer[result_idx++] = '<';
                temp_idx += 4;
            }
            else {
                result_buffer[result_idx++] = temp_buffer[temp_idx++];
            }
        } else {
            result_buffer[result_idx++] = temp_buffer[temp_idx++];
        }
    }
    result_buffer[result_idx] = '\0';

    free(temp_buffer);
    return result_buffer;
}