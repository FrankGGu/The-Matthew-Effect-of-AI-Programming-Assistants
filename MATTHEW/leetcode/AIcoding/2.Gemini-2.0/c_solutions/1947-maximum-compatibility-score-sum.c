#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxCompatibilitySum(int* students, int studentsSize, int* mentors, int mentorsSize) {
    int maxScore = 0;
    int *perm = (int*)malloc(mentorsSize * sizeof(int));
    int *used = (int*)malloc(mentorsSize * sizeof(int));
    for (int i = 0; i < mentorsSize; i++) {
        used[i] = 0;
    }

    void solve(int index, int currentScore) {
        if (index == mentorsSize) {
            if (currentScore > maxScore) {
                maxScore = currentScore;
            }
            return;
        }

        for (int i = 0; i < mentorsSize; i++) {
            if (!used[i]) {
                used[i] = 1;
                perm[index] = i;
                int score = 0;
                for (int j = 0; j < 32; j++) {
                    if (((students[index] >> j) & 1) == ((mentors[i] >> j) & 1)) {
                        score++;
                    }
                }
                solve(index + 1, currentScore + score);
                used[i] = 0;
            }
        }
    }

    solve(0, 0);
    free(perm);
    free(used);
    return maxScore;
}