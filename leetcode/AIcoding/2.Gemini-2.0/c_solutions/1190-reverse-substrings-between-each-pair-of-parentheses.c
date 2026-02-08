#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * reverseParentheses(char * s){
    int len = strlen(s);
    int stack[len];
    int top = -1;
    int start, end;
    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            stack[++top] = i;
        } else if (s[i] == ')') {
            start = stack[top--];
            end = i;
            int l = start + 1;
            int r = end - 1;
            while (l < r) {
                char temp = s[l];
                s[l] = s[r];
                s[r] = temp;
                l++;
                r--;
            }
        }
    }

    char *result = (char *)malloc(sizeof(char) * (len + 1));
    int k = 0;
    for (int i = 0; i < len; i++) {
        if (s[i] != '(' && s[i] != ')') {
            result[k++] = s[i];
        }
    }
    result[k] = '\0';
    return result;
}