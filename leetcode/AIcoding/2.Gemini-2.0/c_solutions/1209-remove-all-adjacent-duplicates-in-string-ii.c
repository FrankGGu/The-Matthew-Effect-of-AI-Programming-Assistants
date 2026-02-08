#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * removeDuplicates(char * s, int k){
    int len = strlen(s);
    char *stack = (char*)malloc((len + 1) * sizeof(char));
    int *count = (int*)malloc((len + 1) * sizeof(int));
    int top = -1;

    for (int i = 0; i < len; i++) {
        if (top == -1 || stack[top] != s[i]) {
            stack[++top] = s[i];
            count[top] = 1;
        } else {
            count[top]++;
            if (count[top] == k) {
                top--;
            } else {
                stack[top] = s[i];
            }
        }
    }

    stack[top + 1] = '\0';
    char *result = (char*)malloc((top + 2) * sizeof(char));
    int index = 0;
    for (int i = 0; i <= top; i++) {
        result[index++] = stack[i];
    }
    result[index] = '\0';

    free(stack);
    free(count);

    return result;
}