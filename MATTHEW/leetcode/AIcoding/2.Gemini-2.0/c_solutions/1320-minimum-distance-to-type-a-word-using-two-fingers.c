#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dp[301][27][27];

int distance(int a, int b) {
    if (a == 26 || b == 26) return 0;
    int rowA = a / 6;
    int colA = a % 6;
    int rowB = b / 6;
    int colB = b % 6;
    return abs(rowA - rowB) + abs(colA - colB);
}

int solve(char* word, int index, int left, int right) {
    if (word[index] == '\0') return 0;

    if (dp[index][left][right] != -1) return dp[index][left][right];

    int currentChar = word[index] - 'A';

    int leftCost = distance(left, currentChar) + solve(word, index + 1, currentChar, right);
    int rightCost = distance(right, currentChar) + solve(word, index + 1, left, currentChar);

    dp[index][left][right] = (leftCost < rightCost) ? leftCost : rightCost;

    return dp[index][left][right];
}

int minimumDistance(char* word) {
    memset(dp, -1, sizeof(dp));
    return solve(word, 0, 26, 26);
}