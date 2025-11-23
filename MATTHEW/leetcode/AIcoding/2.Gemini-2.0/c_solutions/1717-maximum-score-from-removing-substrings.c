#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumGain(char * s, int x, int y) {
    int n = strlen(s);
    int score = 0;
    char stack[n + 1];
    int top = -1;

    for (int i = 0; i < n; i++) {
        stack[++top] = s[i];
        if (top > 0) {
            if (x > y) {
                if (stack[top - 1] == 'a' && stack[top] == 'b') {
                    score += x;
                    top -= 2;
                }
            } else {
                if (stack[top - 1] == 'b' && stack[top] == 'a') {
                    score += y;
                    top -= 2;
                }
            }
        }
    }

    char temp[top + 2];
    for (int i = 0; i <= top; i++) {
        temp[i] = stack[i];
    }
    temp[top + 1] = '\0';

    top = -1;
    char stack2[strlen(temp) + 1];

    for (int i = 0; i < strlen(temp); i++) {
        stack2[++top] = temp[i];
        if (top > 0) {
            if (x > y) {
                if (stack2[top - 1] == 'b' && stack2[top] == 'a') {
                    score += y;
                    top -= 2;
                }
            } else {
                if (stack2[top - 1] == 'a' && stack2[top] == 'b') {
                    score += x;
                    top -= 2;
                }
            }
        }
    }

    return score;
}