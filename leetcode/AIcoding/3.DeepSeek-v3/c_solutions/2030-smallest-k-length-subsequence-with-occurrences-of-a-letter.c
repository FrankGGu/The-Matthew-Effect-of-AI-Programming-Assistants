#include <stdlib.h>
#include <string.h>

char* smallestSubsequence(char* s, int k, char letter, int repetition) {
    int n = strlen(s);
    int total_letter = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == letter) total_letter++;
    }

    char* stack = (char*)malloc((k + 1) * sizeof(char));
    int top = -1;
    int used_letter = 0;
    int remaining_letter = total_letter;

    for (int i = 0; i < n; i++) {
        while (top >= 0 && stack[top] > s[i] && 
               n - i + top + 1 > k && 
               (stack[top] != letter || used_letter + remaining_letter > repetition)) {
            if (stack[top] == letter) {
                used_letter--;
            }
            top--;
        }

        if (top + 1 < k) {
            if (s[i] == letter) {
                stack[++top] = s[i];
                used_letter++;
                remaining_letter--;
            } else {
                if (k - (top + 1) > repetition - used_letter) {
                    stack[++top] = s[i];
                }
            }
        } else {
            if (s[i] == letter) {
                remaining_letter--;
            }
        }
    }

    stack[k] = '\0';
    return stack;
}