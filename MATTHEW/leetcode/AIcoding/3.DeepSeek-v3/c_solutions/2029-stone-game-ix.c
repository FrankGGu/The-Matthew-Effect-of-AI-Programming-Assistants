int stoneGameIX(int* stones, int stonesSize) {
    int count[3] = {0};
    for (int i = 0; i < stonesSize; i++) {
        count[stones[i] % 3]++;
    }

    if (count[0] % 2 == 0) {
        return count[1] > 0 && count[2] > 0;
    } else {
        return abs(count[1] - count[2]) > 2;
    }
}