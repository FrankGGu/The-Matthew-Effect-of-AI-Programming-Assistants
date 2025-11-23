#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *removeDuplicateLetters(char *s) {
    int count[26] = {0};
    bool inStack[26] = {false};
    int len = strlen(s);
    char *stack = (char *)malloc(sizeof(char) * (len + 1));
    int top = -1;
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']--;
        if (inStack[s[i] - 'a']) {
            continue;
        }
        while (top >= 0 && stack[top] > s[i] && count[stack[top] - 'a'] > 0) {
            inStack[stack[top] - 'a'] = false;
            top--;
        }
        stack[++top] = s[i];
        inStack[s[i] - 'a'] = true;
    }
    stack[top + 1] = '\0';
    return stack;
}