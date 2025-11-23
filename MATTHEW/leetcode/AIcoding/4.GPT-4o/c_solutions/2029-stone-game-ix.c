int stoneGameIX(int* stones, int stonesSize) {
    int count[3] = {0};
    for (int i = 0; i < stonesSize; i++) {
        count[stones[i] % 3]++;
    }

    if (count[0] > 0) {
        if (count[1] > 0 && count[2] > 0) {
            return 1;
        }
        if (count[1] > 2) {
            return 1;
        }
        if (count[2] > 2) {
            return 1;
        }
    }
    return 0;
}