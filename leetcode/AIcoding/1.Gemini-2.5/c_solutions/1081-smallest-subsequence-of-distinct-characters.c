#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char* smallestSubsequence(char* s) {
    int freq[26] = {0};
    bool visited[26] = {false};
    char stack[27]; // Max 26 distinct characters + null terminator
    int top = -1;

    for (int i = 0; s[i] != '\0'; i++) {
        freq[s[i] - 'a']++;
    }

    for (int i = 0; s[i] != '\0'; i++) {
        char current_char = s[i];
        int char_idx = current_char - 'a';

        freq[char_idx]--;

        if (visited[char_idx]) {
            continue;
        }

        while (top != -1 && current_char < stack[top] && freq[stack[top] - 'a'] > 0) {
            visited[stack[top] - 'a'] = false;
            top--;
        }

        stack[++top] = current_char;
        visited[char_idx] = true;
    }

    stack[top + 1] = '\0';
    char* result = (char*)malloc(sizeof(char) * (top + 2));
    strcpy(result, stack);

    return result;
}