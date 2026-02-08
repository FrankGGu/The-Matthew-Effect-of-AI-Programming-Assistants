#include <stdlib.h>

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long mostPoints(int** questions, int questionsSize, int* questionsColSize) {
    if (questionsSize == 0) {
        return 0;
    }

    long long* dp = (long long*)malloc((questionsSize + 1) * sizeof(long long));

    dp[questionsSize] = 0;

    for (int i = questionsSize - 1; i >= 0; --i) {
        long long current_points = questions[i][0];
        int brainpower = questions[i][1];

        long long points_if_solve = current_points;
        int next_question_idx = i + brainpower + 1;
        if (next_question_idx <= questionsSize) {
            points_if_solve += dp[next_question_idx];
        }

        long long points_if_skip = dp[i + 1];

        dp[i] = max(points_if_solve, points_if_skip);
    }

    long long result = dp[0];
    free(dp);
    return result;
}