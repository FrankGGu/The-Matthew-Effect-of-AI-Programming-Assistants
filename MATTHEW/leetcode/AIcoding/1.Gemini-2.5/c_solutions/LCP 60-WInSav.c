#include <stdlib.h>
#include <string.h>

typedef struct {
    char ch;
    int count;
} StackElement;

char* removeDuplicates(char* s) {
    int n = strlen(s);

    if (n < 3) {
        char* res = (char*)malloc(sizeof(char) * (n + 1));
        strcpy(res, s);
        return res;
    }

    StackElement* stack = (StackElement*)malloc(sizeof(StackElement) * n);
    int top = -1;

    for (int i = 0; i < n; i++) {
        char current_char = s[i];

        if (top >= 0 && stack[top].ch == current_char) {
            stack[top].count++;
            if (stack[top].count == 3) {
                top--;
            }
        } else {
            top++;
            stack[top].ch = current_char;
            stack[top].count = 1;
        }
    }

    int result_len = 0;
    for (int i = 0; i <= top; i++) {
        result_len += stack[i].count;
    }

    char* result_str = (char*)malloc(sizeof(char) * (result_len + 1));
    int current_idx = 0;
    for (int i = 0; i <= top; i++) {
        for (int j = 0; j < stack[i].count; j++) {
            result_str[current_idx++] = stack[i].ch;
        }
    }
    result_str[current_idx] = '\0';

    free(stack);

    return result_str;
}