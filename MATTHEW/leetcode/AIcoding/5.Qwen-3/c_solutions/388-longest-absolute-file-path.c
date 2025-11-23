#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lengthLongestPath(char *input) {
    int max_len = 0;
    int stack[256] = {0};
    int top = -1;
    int i = 0;
    int len = 0;
    int depth = 0;
    int is_file = 0;

    while (input[i] != '\0') {
        if (input[i] == '\n') {
            i++;
            len = 0;
            depth = 0;
            while (input[i] == '\t') {
                i++;
                depth++;
            }
            while (input[i] != '\n' && input[i] != '\0') {
                if (input[i] == '.') is_file = 1;
                len++;
                i++;
            }
            if (is_file) {
                int total_len = 0;
                for (int j = 0; j <= depth; j++) {
                    total_len += stack[j];
                }
                total_len += depth;
                if (total_len > max_len) max_len = total_len;
            } else {
                top = depth - 1;
                stack[depth] = len;
            }
            is_file = 0;
        } else {
            i++;
        }
    }

    return max_len;
}