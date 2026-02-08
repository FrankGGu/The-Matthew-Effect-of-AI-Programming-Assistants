#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char* removeDuplicateLetters(char* s) {
    int count[26] = {0};
    bool inStack[26] = {false};

    for (int i = 0; s[i] != '\0'; i++) {
        count[s[i] - 'a']++;
    }

    char stack[27]; 
    int top = -1; 

    for (int i = 0; s[i] != '\0'; i++) {
        char currentChar = s[i];
        count[currentChar - 'a']--;

        if (inStack[currentChar - 'a']) {
            continue;
        }

        while (top != -1 && currentChar < stack[top] && count[stack[top] - 'a'] > 0) {
            inStack[stack[top] - 'a'] = false;
            top--;
        }

        stack[++top] = currentChar;
        inStack[currentChar - 'a'] = true;
    }

    char* result = (char*)malloc((top + 2) * sizeof(char));
    if (result == NULL) {
        return NULL;
    }

    for (int i = 0; i <= top; i++) {
        result[i] = stack[i];
    }
    result[top + 1] = '\0';

    return result;
}