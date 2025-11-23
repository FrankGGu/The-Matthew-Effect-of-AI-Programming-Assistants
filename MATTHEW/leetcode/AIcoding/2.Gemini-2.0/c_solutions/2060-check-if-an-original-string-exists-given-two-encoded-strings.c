#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isNumber(char c) {
    return c >= '0' && c <= '9';
}

int getNumber(const char *s, int *idx) {
    int num = 0;
    while (*idx < strlen(s) && isNumber(s[*idx])) {
        num = num * 10 + (s[*idx] - '0');
        (*idx)++;
    }
    return num;
}

int solve(const char *s1, const char *s2, int i, int j, int len1, int len2, int ***dp) {
    if (i == len1 && j == len2) {
        return 1;
    }
    if (dp[i][j] != NULL) {
        return *dp[i][j];
    }

    int *res = (int *)malloc(sizeof(int));
    *res = 0;

    if (i < len1 && !isNumber(s1[i])) {
        if (j < len2 && !isNumber(s2[j]) && s1[i] == s2[j]) {
            *res = solve(s1, s2, i + 1, j + 1, len1, len2, dp);
        }
    } else if (i < len1 && isNumber(s1[i])) {
        int idx1 = i;
        int num1 = getNumber(s1, &idx1);
        if (j < len2) {
            *res = solve(s1, s2, idx1, j + num1, len1, len2, dp);
        }
    }

    if (*res == 0 && j < len2 && !isNumber(s2[j])) {
        if (i < len1 && !isNumber(s1[i]) && s1[i] == s2[j]) {
        } else {

        }
    } else if (*res == 0 && j < len2 && isNumber(s2[j])) {
        int idx2 = j;
        int num2 = getNumber(s2, &idx2);
        if (i < len1) {
            *res = solve(s1, s2, i + num2, idx2, len1, len2, dp);
        }
    }

    if (*res == 0 && i < len1 && isNumber(s1[i]) && j < len2 && isNumber(s2[j])) {
        int idx1 = i;
        int num1 = getNumber(s1, &idx1);
        int idx2 = j;
        int num2 = getNumber(s2, &idx2);
        if (num1 > num2) {
            char newNum1[20];
            sprintf(newNum1, "%d", num1 - num2);
            int newLen1 = strlen(newNum1);
            char *newS1 = (char *)malloc(strlen(s1) + newLen1 + 1);
            strncpy(newS1, s1, idx1);
            newS1[idx1] = '\0';
            strcat(newS1, newNum1);
            strcat(newS1, s1 + idx1);
            *res = solve(newS1, s2, idx1 - (idx1 - i), idx2, strlen(newS1), len2, dp);
            free(newS1);

        } else if (num2 > num1) {
            char newNum2[20];
            sprintf(newNum2, "%d", num2 - num1);
            int newLen2 = strlen(newNum2);
            char *newS2 = (char *)malloc(strlen(s2) + newLen2 + 1);
            strncpy(newS2, s2, idx2);
            newS2[idx2] = '\0';
            strcat(newS2, newNum2);
            strcat(newS2, s2 + idx2);
            *res = solve(s1, newS2, idx1, idx2 - (idx2 - j), len1, strlen(newS2), dp);
            free(newS2);
        } else {
            *res = solve(s1, s2, idx1, idx2, len1, len2, dp);
        }
    }

    dp[i][j] = res;
    return *res;
}

bool possiblyEquals(char *s1, char *s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    int ***dp = (int ***)malloc((len1 + 1) * sizeof(int **));
    for (int i = 0; i <= len1; i++) {
        dp[i] = (int **)malloc((len2 + 1) * sizeof(int *));
        for (int j = 0; j <= len2; j++) {
            dp[i][j] = NULL;
        }
    }

    int result = solve(s1, s2, 0, 0, len1, len2, dp);

    for (int i = 0; i <= len1; i++) {
        for (int j = 0; j <= len2; j++) {
            if (dp[i][j] != NULL) {
                free(dp[i][j]);
            }
        }
        free(dp[i]);
    }
    free(dp);

    return result == 1;
}