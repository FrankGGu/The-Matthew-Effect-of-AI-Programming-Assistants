#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

bool isValid(char* code) {
    int len = strlen(code);
    if (len == 0 || code[0] != '<') return false;

    char** stack = (char**)malloc(len * sizeof(char*));
    int top = -1;

    for (int i = 0; i < len; ) {
        if (i > 0 && top == -1) return false;

        if (code[i] == '<') {
            if (i + 1 >= len) return false;

            if (code[i + 1] == '!') {
                if (top == -1) return false;
                if (i + 9 >= len || strncmp(code + i, "<![CDATA[", 9) != 0) return false;
                int j = i + 9;
                while (j + 2 < len && strncmp(code + j, "]]>", 3) != 0) j++;
                if (j + 2 >= len) return false;
                i = j + 3;
            } else if (code[i + 1] == '/') {
                int j = i + 2;
                while (j < len && code[j] != '>') j++;
                if (j >= len || j == i + 2 || j - i - 2 > 9) return false;
                if (top == -1) return false;
                if (strncmp(code + i + 2, stack[top], j - i - 2) != 0) return false;
                free(stack[top]);
                top--;
                i = j + 1;
            } else {
                int j = i + 1;
                while (j < len && code[j] != '>') j++;
                if (j >= len || j == i + 1 || j - i - 1 > 9) return false;
                for (int k = i + 1; k < j; k++) {
                    if (code[k] < 'A' || code[k] > 'Z') return false;
                }
                char* tag = (char*)malloc(10);
                strncpy(tag, code + i + 1, j - i - 1);
                tag[j - i - 1] = '\0';
                stack[++top] = tag;
                i = j + 1;
            }
        } else {
            i++;
        }
    }

    for (int i = 0; i <= top; i++) {
        free(stack[i]);
    }
    free(stack);

    return top == -1;
}