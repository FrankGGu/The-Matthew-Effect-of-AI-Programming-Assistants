int bestHand(int* ranks, int ranksSize, char* suits, int suitsSize) {
    int flush = 1;
    for (int i = 1; i < suitsSize; i++) {
        if (suits[i] != suits[0]) {
            flush = 0;
            break;
        }
    }
    if (flush) return 4;

    int count[14] = {0};
    int maxCount = 0;
    for (int i = 0; i < ranksSize; i++) {
        count[ranks[i]]++;
        if (count[ranks[i]] > maxCount) {
            maxCount = count[ranks[i]];
        }
    }

    if (maxCount >= 3) return 3;
    if (maxCount == 2) return 2;
    return 1;
}