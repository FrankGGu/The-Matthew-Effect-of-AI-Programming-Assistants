#include <stdlib.h>
#include <string.h>
#include <stdio.h>

char* generateNext(char* prev) {
    int prev_len = strlen(prev);
    int max_next_len = 2 * prev_len + 1; 
    char* next_str = (char*)malloc(max_next_len * sizeof(char));
    if (!next_str) {
        return NULL;
    }

    int write_idx = 0;
    int read_idx = 0;

    while (read_idx < prev_len) {
        char current_char = prev[read_idx];
        int count = 0;
        while (read_idx < prev_len && prev[read_idx] == current_char) {
            count++;
            read_idx++;
        }
        write_idx += sprintf(next_str + write_idx, "%d", count);
        next_str[write_idx++] = current_char;
    }
    next_str[write_idx] = '\0';
    return next_str;
}

char* countAndSay(int n) {
    if (n == 1) {
        return strdup("1");
    }

    char* current_str = strdup("1");
    if (!current_str) {
        return NULL;
    }

    for (int i = 2; i <= n; i++) {
        char* next_str = generateNext(current_str);
        free(current_str);
        current_str = next_str;
        if (!current_str) {
            return NULL;
        }
    }

    return current_str;
}