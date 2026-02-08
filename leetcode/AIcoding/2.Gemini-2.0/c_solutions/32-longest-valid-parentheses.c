#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestValidParentheses(char * s){
    int maxLen = 0;
    int stack[strlen(s) + 1];
    int top = -1;
    stack[++top] = -1;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            stack[++top] = i;
        } else {
            if (top > -1) {
                top--;
            }
            if (top == -1) {
                stack[++top] = i;
            } else {
                int len = i - stack[top];
                if (len > maxLen) {
                    maxLen = len;
                }
            }
        }
    }

    return maxLen;
}