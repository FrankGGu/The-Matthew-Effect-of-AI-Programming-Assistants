int stoneGameVI(int* A, int ASize, int* B, int BSize) {
    int scores[2][2] = {0};
    for (int i = 0; i < ASize; i++) {
        scores[0][0] = A[i];
        scores[0][1] = B[i];
        scores[1][0] = A[i];
        scores[1][1] = B[i];
    }

    int total[2] = {0};
    for (int i = 0; i < 2; i++) {
        if (scores[i][0] > scores[i][1]) {
            total[0] += scores[i][0];
            total[1] += scores[1 - i][1];
        } else {
            total[0] += scores[i][1];
            total[1] += scores[1 - i][0];
        }
    }

    if (total[0] > total[1]) return 1;
    else if (total[0] < total[1]) return -1;
    return 0;
}