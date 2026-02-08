#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int solve(int** questions, int questionsSize, int* questionsColSize, int index, int* dp) {
    if (index >= questionsSize) {
        return 0;
    }
    if (dp[index] != -1) {
        return dp[index];
    }
    int take = questions[index][0] + solve(questions, questionsSize, questionsColSize, index + questions[index][1] + 1, dp);
    int notTake = solve(questions, questionsSize, questionsColSize, index + 1, dp);
    dp[index] = max(take, notTake);
    return dp[index];
}

int mostPoints(int** questions, int questionsSize, int* questionsColSize) {
    int* dp = (int*)malloc(questionsSize * sizeof(int));
    for (int i = 0; i < questionsSize; i++) {
        dp[i] = -1;
    }
    return solve(questions, questionsSize, questionsColSize, 0, dp);
}