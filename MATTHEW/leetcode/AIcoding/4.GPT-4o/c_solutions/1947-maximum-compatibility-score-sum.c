int calculateCompatibility(int* student, int* mentor, int m) {
    int score = 0;
    for (int i = 0; i < m; i++) {
        score += (student[i] == mentor[i]) ? 1 : 0;
    }
    return score;
}

void backtrack(int** student, int** mentor, int m, int n, int index, int* used, int currentScore, int* maxScore) {
    if (index == n) {
        if (currentScore > *maxScore) {
            *maxScore = currentScore;
        }
        return;
    }

    for (int i = 0; i < n; i++) {
        if (!used[i]) {
            used[i] = 1;
            backtrack(student, mentor, m, n, index + 1, used, currentScore + calculateCompatibility(student[index], mentor[i], m), maxScore);
            used[i] = 0;
        }
    }
}

int maxCompatibilitySum(int** students, int studentsSize, int* studentsColSize, int** mentors, int mentorsSize, int* mentorsColSize) {
    int maxScore = 0;
    int* used = (int*)malloc(mentorsSize * sizeof(int));
    memset(used, 0, mentorsSize * sizeof(int));
    backtrack(students, mentors, studentsColSize[0], studentsSize, 0, used, 0, &maxScore);
    free(used);
    return maxScore;
}