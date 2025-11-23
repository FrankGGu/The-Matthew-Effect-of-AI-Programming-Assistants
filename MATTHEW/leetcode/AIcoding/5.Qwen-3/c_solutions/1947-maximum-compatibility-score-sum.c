#include <stdio.h>
#include <stdlib.h>

int maxCompatibilityScore(int** students, int studentsSize, int* studentsColSize, int** mentors, int mentorsSize, int* mentorsColSize) {
    int n = studentsSize;
    int m = studentsColSize[0];

    int** score = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        score[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int s = 0;
            for (int k = 0; k < m; k++) {
                s += students[i][k] == mentors[j][k] ? 1 : 0;
            }
            score[i][j] = s;
        }
    }

    int* perm = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        perm[i] = i;
    }

    int maxSum = 0;

    int* used = (int*)malloc(n * sizeof(int));

    void backtrack(int index, int currentSum) {
        if (index == n) {
            maxSum = (currentSum > maxSum) ? currentSum : maxSum;
            return;
        }
        for (int i = 0; i < n; i++) {
            if (!used[i]) {
                used[i] = 1;
                backtrack(index + 1, currentSum + score[index][i]);
                used[i] = 0;
            }
        }
    }

    backtrack(0, 0);

    for (int i = 0; i < n; i++) {
        free(score[i]);
    }
    free(score);
    free(perm);
    free(used);

    return maxSum;
}