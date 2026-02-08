int maxScore;

void backtrack(int** students, int** mentors, int m, int n, int idx, int used, int score) {
    if (idx == m) {
        if (score > maxScore) {
            maxScore = score;
        }
        return;
    }

    for (int i = 0; i < m; i++) {
        if (used & (1 << i)) continue;

        int currentScore = 0;
        for (int j = 0; j < n; j++) {
            if (students[idx][j] == mentors[i][j]) {
                currentScore++;
            }
        }

        backtrack(students, mentors, m, n, idx + 1, used | (1 << i), score + currentScore);
    }
}

int maxCompatibilitySum(int** students, int studentsSize, int* studentsColSize, int** mentors, int mentorsSize, int* mentorsColSize) {
    maxScore = 0;
    backtrack(students, mentors, studentsSize, studentsColSize[0], 0, 0, 0);
    return maxScore;
}