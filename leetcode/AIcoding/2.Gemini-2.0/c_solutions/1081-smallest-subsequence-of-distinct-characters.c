#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *smallestSubsequence(char *s) {
    int count[26] = {0};
    bool in_stack[26] = {false};
    char *stack = (char *)malloc(strlen(s) + 1);
    int top = -1;

    for (int i = 0; s[i] != '\0'; i++) {
        count[s[i] - 'a']++;
    }

    for (int i = 0; s[i] != '\0'; i++) {
        count[s[i] - 'a']--;

        if (in_stack[s[i] - 'a']) {
            continue;
        }

        while (top >= 0 && stack[top] > s[i] && count[stack[top] - 'a'] > 0) {
            in_stack[stack[top] - 'a'] = false;
            top--;
        }

        stack[++top] = s[i];
        in_stack[s[i] - 'a'] = true;
    }

    stack[top + 1] = '\0';
    return stack;
}