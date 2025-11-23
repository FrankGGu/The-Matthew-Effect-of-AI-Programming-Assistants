#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void backtrack(char *s, int start, char **current, int *count, char ***result) {
    if (*count == 4) {
        if (start == strlen(s)) {
            char *ip = (char *)malloc(16 * sizeof(char));
            sprintf(ip, "%s.%s.%s.%s", current[0], current[1], current[2], current[3]);
            result[*count] = ip;
            (*count)++;
        }
        return;
    }

    for (int i = start; i < strlen(s); i++) {
        if (i > start && s[start] == '0') break;
        char *part = (char *)malloc(i - start + 2);
        strncpy(part, s + start, i - start + 1);
        part[i - start + 1] = '\0';
        if (atoi(part) <= 255) {
            current[*count] = part;
            (*count)++;
            backtrack(s, i + 1, current, count, result);
            (*count]--;
            free(part);
        }
    }
}

char **restoreIpAddresses(char *s, int *returnSize) {
    char **result = (char **)malloc(100 * sizeof(char *));
    char *current[4];
    int count = 0;
    backtrack(s, 0, current, &count, result);
    *returnSize = count;
    return result;
}