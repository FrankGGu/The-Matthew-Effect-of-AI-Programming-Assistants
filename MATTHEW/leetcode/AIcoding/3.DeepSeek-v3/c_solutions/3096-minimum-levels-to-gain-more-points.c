int minimumLevels(int* possible, int possibleSize) {
    int total = 0;
    for (int i = 0; i < possibleSize; i++) {
        total += (possible[i] == 1) ? 1 : -1;
    }

    int daniel = 0;
    for (int i = 0; i < possibleSize - 1; i++) {
        daniel += (possible[i] == 1) ? 1 : -1;
        int bob = total - daniel;
        if (daniel > bob) {
            return i + 1;
        }
    }

    return -1;
}