int minDominoRotations(int* tops, int topsSize, int* bottoms, int bottomsSize) {
    int countA[7] = {0}, countB[7] = {0}, same[7] = {0};

    for (int i = 0; i < topsSize; i++) {
        countA[tops[i]]++;
        countB[bottoms[i]]++;
        if (tops[i] == bottoms[i]) {
            same[tops[i]]++;
        }
    }

    for (int i = 1; i <= 6; i++) {
        if (countA[i] + countB[i] - same[i] == topsSize) {
            return topsSize - (countA[i] > countB[i] ? countA[i] : countB[i]);
        }
    }

    return -1;
}