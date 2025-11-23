#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ***partition(char *s, int *returnSize) {
    int n = strlen(s);
    char ***result = (char ***)malloc(sizeof(char **) * 1000);
    *returnSize = 0;

    char **current = (char **)malloc(sizeof(char *) * n);

    int isPalindrome(int start, int end) {
        while (start < end) {
            if (s[start] != s[end]) return 0;
            start++;
            end--;
        }
        return 1;
    }

    void backtrack(int start, int depth) {
        if (start == n) {
            result[*returnSize] = (char **)malloc(sizeof(char *) * depth);
            for (int i = 0; i < depth; i++) {
                result[*returnSize][i] = strdup(current[i]);
            }
            (*returnSize)++;
            return;
        }

        for (int end = start; end < n; end++) {
            if (isPalindrome(start, end)) {
                current[depth] = (char *)malloc(end - start + 2);
                strncpy(current[depth], s + start, end - start + 1);
                current[depth][end - start + 1] = '\0';
                backtrack(end + 1, depth + 1);
            }
        }
    }

    backtrack(0, 0);
    return result;
}