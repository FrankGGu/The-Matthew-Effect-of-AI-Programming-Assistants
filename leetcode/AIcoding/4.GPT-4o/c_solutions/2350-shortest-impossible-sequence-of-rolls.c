int shortestImpossibleSequence(int* rolls, int rollsSize) {
    int count[7] = {0};
    for (int i = 0; i < rollsSize; i++) {
        count[rolls[i]]++;
    }

    for (int length = 1; length <= 6; length++) {
        int total = 0;
        for (int i = 1; i <= 6; i++) {
            total += count[i] > 0 ? 1 : 0;
            if (total == length) {
                break;
            }
        }
        if (total < length) {
            return length;
        }
    }
    return 7;
}