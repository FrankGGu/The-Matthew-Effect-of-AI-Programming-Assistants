#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

void append_char(char** str, int* len, int* capacity, char c) {
    if (*len + 1 >= *capacity) {
        *capacity = (*capacity == 0) ? 16 : *capacity * 2;
        *str = (char*)realloc(*str, *capacity);
    }
    (*str)[(*len)++] = c;
    (*str)[*len] = '\0';
}

char** removeComments(char** source, int sourceSize, int* returnSize) {
    char** result = NULL;
    *returnSize = 0;

    bool in_block_comment = false;
    char* current_line_buffer = NULL;
    int current_line_len = 0;
    int current_line_capacity = 0;

    for (int i = 0; i < sourceSize; ++i) {
        char* line = source[i];
        int line_len = strlen(line);

        for (int j = 0; j < line_len; ++j) {
            if (in_block_comment) {
                if (j + 1 < line_len && line[j] == '*' && line[j+1] == '/') {
                    in_block_comment = false;
                    j++;
                }
            } else {
                if (j + 1 < line_len && line[j] == '/' && line[j+1] == '/') {
                    break; 
                } else if (j + 1 < line_len && line[j] == '/' && line[j+1] == '*') {
                    in_block_comment = true;
                    j++;
                } else {
                    append_char(&current_line_buffer, &current_line_len, &current_line_capacity, line[j]);
                }
            }
        }

        if (!in_block_comment) {
            if (current_line_len > 0) {
                result = (char**)realloc(result, (*returnSize + 1) * sizeof(char*));
                result[*returnSize] = current_line_buffer;
                (*returnSize)++;
            } else if (current_line_buffer != NULL) {
                free(current_line_buffer);
            }
            current_line_buffer = NULL;
            current_line_len = 0;
            current_line_capacity = 0;
        }
    }

    if (current_line_buffer != NULL) {
        free(current_line_buffer);
    }

    return result;
}