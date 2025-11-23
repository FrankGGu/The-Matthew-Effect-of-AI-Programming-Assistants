#include <stdlib.h>
#include <string.h>

char* finalString(char* s) {
    int s_len = strlen(s);
    char* result = (char*)malloc(s_len + 1); // Allocate memory for the result string
    int current_len = 0; // Tracks the current length of the string in 'result'

    for (int i = 0; i < s_len; i++) {
        if (s[i] == 'i') {
            // If 'i' is encountered, reverse the string built so far
            for (int j = 0; j < current_len / 2; j++) {
                char temp = result[j];
                result[j] = result[current_len - 1 - j];
                result[current_len - 1 - j] = temp;
            }
        } else {
            // If not 'i', append the character to the result string
            result[current_len] = s[i];
            current_len++;
        }
    }
    // Null-terminate the final string
    result[current_len] = '\0';

    return result;
}