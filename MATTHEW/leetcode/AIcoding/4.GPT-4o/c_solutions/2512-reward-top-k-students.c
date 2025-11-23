int* topKStudents(int** score, int scoreSize, int k, int* returnSize) {
    int* result = (int*)malloc(k * sizeof(int));
    int* indices = (int*)malloc(scoreSize * sizeof(int));
    double* averageScores = (double*)malloc(scoreSize * sizeof(double));

    for (int i = 0; i < scoreSize; i++) {
        double sum = 0;
        for (int j = 0; j < 5; j++) {
            sum += score[i][j];
        }
        averageScores[i] = sum / 5;
        indices[i] = i;
    }

    for (int i = 0; i < scoreSize - 1; i++) {
        for (int j = 0; j < scoreSize - i - 1; j++) {
            if (averageScores[indices[j]] < averageScores[indices[j + 1]]) {
                int tempIndex = indices[j];
                indices[j] = indices[j + 1];
                indices[j + 1] = tempIndex;
            }
        }
    }

    for (int i = 0; i < k; i++) {
        result[i] = indices[i];
    }

    *returnSize = k;
    free(indices);
    free(averageScores);
    return result;
}