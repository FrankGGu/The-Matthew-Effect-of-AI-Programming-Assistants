#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* smallestSubsequence(char* s, int k, char letter, int repetition) {
    int n = strlen(s);
    char* stack = (char*)malloc((k + 1) * sizeof(char));
    int top = 0;
    int letterCount = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == letter) {
            letterCount++;
        }
    }
    for (int i = 0; i < n; i++) {
        while (top > 0 && stack[top - 1] > s[i] && n - i + top > k &&
               (stack[top - 1] != letter || letterCount > repetition)) {
            if (stack[top - 1] == letter) {
                repetition++;
            }
            top--;
        }
        if (top < k) {
            stack[top++] = s[i];
            if (s[i] == letter) {
                repetition--;
            }
        } else {
            if (s[i] == letter) {
                letterCount--;
            }
        }
    }
    stack[top] = '\0';

    int letterInStack = 0;
    for (int i = 0; i < k; i++) {
        if (stack[i] == letter) {
            letterInStack++;
        }
    }

    if (letterInStack < repetition) {
        int diff = repetition - letterInStack;
        int index = k - 1;
        while (diff > 0) {
            if (stack[index] != letter) {
                stack[index] = letter;
                diff--;
            }
            index--;
        }
        qsort(stack, k, sizeof(char), (int (*)(const void *, const void *))strcmp);
    }

    return stack;
}