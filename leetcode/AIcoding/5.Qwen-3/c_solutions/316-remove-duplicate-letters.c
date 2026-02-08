#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeDuplicateLetters(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int* visited = (int*)calloc(26, sizeof(int));
    int* lastOccur = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < len; ++i) {
        lastOccur[s[i] - 'a'] = i;
    }
    int top = -1;
    for (int i = 0; i < len; ++i) {
        char c = s[i];
        if (visited[c - 'a']) {
            continue;
        }
        while (top >= 0 && s[i] < s[top] && lastOccur[s[top] - 'a'] > i) {
            visited[s[top] - 'a'] = 0;
            top--;
        }
        result[++top] = c;
        visited[c - 'a'] = 1;
    }
    result[top + 1] = '\0';
    return result;
}