#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isValid(char * code) {
    int n = strlen(code);
    if (n == 0) return false;
    if (code[0] != '<' || code[n - 1] != '>') return false;

    char stack[1000];
    int stack_size = 0;
    int i = 0;

    while (i < n) {
        if (code[i] == '<') {
            if (i == n - 1) return false;
            if (code[i + 1] == '/') {
                int j = i + 2;
                while (j < n && code[j] != '>') j++;
                if (j == n) return false;

                int tag_len = j - (i + 2);
                if (tag_len < 1 || tag_len > 9) return false;
                for (int k = i + 2; k < j; k++) {
                    if (code[k] < 'A' || code[k] > 'Z') return false;
                }

                char tag[10];
                strncpy(tag, code + i + 2, tag_len);
                tag[tag_len] = '\0';

                if (stack_size == 0) return false;
                if (strcmp(stack + stack_size - tag_len, tag) != 0) return false;
                stack_size -= tag_len;
                i = j + 1;
            } else if (code[i + 1] == '!') {
                if (stack_size == 0) return false;
                if (i + 9 >= n || strncmp(code + i + 2, "[CDATA[", 7) != 0) return false;
                int j = i + 9;
                while (j < n - 2 && strncmp(code + j, "]]>", 3) != 0) j++;
                if (j >= n - 2) return false;
                i = j + 3;
            } else {
                int j = i + 1;
                while (j < n && code[j] != '>') j++;
                if (j == n) return false;

                int tag_len = j - (i + 1);
                if (tag_len < 1 || tag_len > 9) return false;
                for (int k = i + 1; k < j; k++) {
                    if (code[k] < 'A' || code[k] > 'Z') return false;
                }

                if (stack_size + tag_len >= 1000) return false;
                strncpy(stack + stack_size, code + i + 1, tag_len);
                stack_size += tag_len;
                i = j + 1;
            }
        } else {
            if (stack_size == 0) return false;
            i++;
        }
    }

    return stack_size == 0;
}