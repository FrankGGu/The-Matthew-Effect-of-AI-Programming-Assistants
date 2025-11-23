int dfs(int* price, int priceSize, int* special, int specialSize, int* needs, int needsSize) {
    int total = 0;
    for (int i = 0; i < needsSize; i++) {
        total += price[i] * needs[i];
    }

    for (int i = 0; i < specialSize; i++) {
        int* nextNeeds = (int*)malloc(needsSize * sizeof(int));
        int valid = 1;
        for (int j = 0; j < needsSize; j++) {
            if (needs[j] < special[i * (needsSize + 1) + j]) {
                valid = 0;
                break;
            }
            nextNeeds[j] = needs[j] - special[i * (needsSize + 1) + j];
        }

        if (valid) {
            int offerPrice = special[i * (needsSize + 1) + needsSize];
            total = fmin(total, offerPrice + dfs(price, priceSize, special, specialSize, nextNeeds, needsSize));
        }

        free(nextNeeds);
    }

    return total;
}

int shoppingOffers(int* price, int priceSize, int** special, int specialSize, int* needs, int needsSize) {
    return dfs(price, priceSize, (int*)special, specialSize, needs, needsSize);
}