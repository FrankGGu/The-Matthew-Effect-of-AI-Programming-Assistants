int minimumCardPickup(int* cards, int cardsSize) {
    int minPickup = INT_MAX;
    int lastIndex[100001] = {0};

    for (int i = 0; i < cardsSize; i++) {
        if (lastIndex[cards[i]] > 0) {
            minPickup = fmin(minPickup, i - lastIndex[cards[i]] + 1);
        }
        lastIndex[cards[i]] = i + 1;
    }

    return minPickup == INT_MAX ? -1 : minPickup;
}