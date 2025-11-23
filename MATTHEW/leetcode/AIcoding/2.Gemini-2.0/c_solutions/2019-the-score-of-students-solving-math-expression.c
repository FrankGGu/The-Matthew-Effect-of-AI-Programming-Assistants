#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LEN 31
#define MAX_NUM 201

int scoreOfStudents(char * s, int sSize, int * answers, int answersSize) {
    int dp[MAX_LEN][MAX_LEN][MAX_NUM] = {0};
    int nums[MAX_LEN / 2 + 1];
    char ops[MAX_LEN / 2];
    int numCount = 0, opCount = 0;

    for (int i = 0; i < sSize; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            nums[numCount++] = s[i] - '0';
        } else {
            ops[opCount++] = s[i];
        }
    }

    for (int i = 0; i < numCount; i++) {
        dp[i][i][nums[i]] = 1;
    }

    for (int len = 2; len <= numCount; len++) {
        for (int i = 0; i <= numCount - len; i++) {
            int j = i + len - 1;
            for (int k = i; k < j; k++) {
                char op = ops[k];
                if (op == '+') {
                    for (int m = 0; m < MAX_NUM; m++) {
                        for (int n = 0; n < MAX_NUM; n++) {
                            if (dp[i][k][m] && dp[k + 1][j][n] && m + n < MAX_NUM) {
                                dp[i][j][m + n] = 1;
                            }
                        }
                    }
                } else if (op == '*') {
                    for (int m = 0; m < MAX_NUM; m++) {
                        for (int n = 0; n < MAX_NUM; n++) {
                            if (dp[i][k][m] && dp[k + 1][j][n] && m * n < MAX_NUM) {
                                dp[i][j][m * n] = 1;
                            }
                        }
                    }
                }
            }
        }
    }

    int correctAns = nums[0];
    for (int i = 0; i < opCount; i++) {
        if (ops[i] == '+') {
            correctAns += nums[i + 1];
        } else {
            correctAns *= nums[i + 1];
        }
    }

    int score = 0;
    for (int i = 0; i < answersSize; i++) {
        if (answers[i] == correctAns) {
            score += 5;
        } else if (answers[i] < MAX_NUM && dp[0][numCount - 1][answers[i]]) {
            score += 2;
        }
    }

    return score;
}