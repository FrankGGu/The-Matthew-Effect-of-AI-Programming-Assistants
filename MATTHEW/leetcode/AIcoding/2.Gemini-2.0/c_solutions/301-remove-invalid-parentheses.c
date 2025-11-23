#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LEN 30

int isValid(char *s) {
    int count = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            count++;
        } else if (s[i] == ')') {
            count--;
        }
        if (count < 0) {
            return 0;
        }
    }
    return count == 0;
}

char** removeInvalidParentheses(char* s, int* returnSize) {
    char** result = (char**)malloc(1000 * sizeof(char*));
    int resultIndex = 0;
    int visited[1 << MAX_LEN] = {0};
    char queue[1000][MAX_LEN + 1];
    int head = 0, tail = 0;

    strcpy(queue[tail++], s);
    visited[0] = 1;

    int found = 0;
    while (head < tail) {
        char* current = queue[head++];

        if (isValid(current)) {
            result[resultIndex] = (char*)malloc((strlen(current) + 1) * sizeof(char));
            strcpy(result[resultIndex++], current);
            found = 1;
        }

        if (found) continue;

        for (int i = 0; current[i] != '\0'; i++) {
            if (current[i] != '(' && current[i] != ')') continue;

            char temp[MAX_LEN + 1];
            strcpy(temp, current);
            memmove(temp + i, temp + i + 1, strlen(temp) - i);

            unsigned int hash = 0;
            for (int j = 0; temp[j] != '\0'; j++) {
                hash = hash * 31 + temp[j];
            }

            if (!visited[hash]) {
                visited[hash] = 1;
                strcpy(queue[tail++], temp);
            }
        }
    }

    *returnSize = resultIndex;
    if (resultIndex == 0) {
        result[0] = (char*)malloc(1 * sizeof(char));
        result[0][0] = '\0';
        *returnSize = 1;
    }

    return result;
}