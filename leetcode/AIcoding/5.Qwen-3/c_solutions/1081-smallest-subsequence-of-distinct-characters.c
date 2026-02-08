#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeDuplicateLetters(char* s) {
    int len = strlen(s);
    int seen[26] = {0};
    int count[26] = {0};
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    int top = -1;

    for (int i = 0; i < len; i++) {
        char c = s[i];
        if (seen[c - 'a']) {
            count[c - 'a']--;
            continue;
        }

        while (top >= 0 && s[i] < result[top] && count[result[top] - 'a'] > 0) {
            seen[result[top] - 'a'] = 0;
            top--;
        }

        result[++top] = c;
        seen[c - 'a'] = 1;
        count[c - 'a']--;
    }

    result[++top] = '\0';
    return result;
}