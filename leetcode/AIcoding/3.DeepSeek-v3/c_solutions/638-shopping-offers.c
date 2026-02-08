int minCost;

void backtrack(int* price, int priceSize, int** special, int specialSize, int* specialColSize, int* needs, int needsSize, int cost) {
    int total = cost;
    for (int i = 0; i < needsSize; i++) {
        total += price[i] * needs[i];
    }
    if (total < minCost) {
        minCost = total;
    }

    for (int i = 0; i < specialSize; i++) {
        int valid = 1;
        for (int j = 0; j < needsSize; j++) {
            if (special[i][j] > needs[j]) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            for (int j = 0; j < needsSize; j++) {
                needs[j] -= special[i][j];
            }
            backtrack(price, priceSize, special, specialSize, specialColSize, needs, needsSize, cost + special[i][needsSize]);
            for (int j = 0; j < needsSize; j++) {
                needs[j] += special[i][j];
            }
        }
    }
}

int shoppingOffers(int* price, int priceSize, int** special, int specialSize, int* specialColSize, int* needs, int needsSize) {
    minCost = 0;
    for (int i = 0; i < needsSize; i++) {
        minCost += price[i] * needs[i];
    }

    backtrack(price, priceSize, special, specialSize, specialColSize, needs, needsSize, 0);
    return minCost;
}