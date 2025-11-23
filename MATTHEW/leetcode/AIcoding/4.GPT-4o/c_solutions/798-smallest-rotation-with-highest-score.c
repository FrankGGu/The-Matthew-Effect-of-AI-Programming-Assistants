int bestRotation(int* A, int ASize) {
    int *score = (int*)calloc(ASize, sizeof(int));
    for (int i = 0; i < ASize; i++) {
        score[(i - A[i] + 1 + ASize) % ASize]--;
        score[(i + 1) % ASize]++;
    }
    int maxScore = score[0], bestK = 0;
    for (int i = 1; i < ASize; i++) {
        score[i] += score[i - 1];
        if (score[i] > maxScore) {
            maxScore = score[i];
            bestK = i;
        }
    }
    free(score);
    return bestK;
}