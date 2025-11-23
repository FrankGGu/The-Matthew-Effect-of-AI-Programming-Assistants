#include <string.h>
#include <stdlib.h>

char* removeDuplicates(char* s) {
    int n = strlen(s);
    char* stack = (char*)malloc(sizeof(char) * (n + 1));
    int top = -1;

    for (int i = 0; i < n; i++) {
        if (top != -1 && stack[top] == s[i]) {
            top--;
        } else {
            top++;
            stack[top] = s[i];
        }
    }

    stack[top + 1] = '\0';
    return stack;
}