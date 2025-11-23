int maxIceCream(int* costs, int costsSize, int coins) {
    int count = 0;
    int i, j;

    // Sort the costs
    for (i = 0; i < costsSize - 1; i++) {
        for (j = 0; j < costsSize - i - 1; j++) {
            if (costs[j] > costs[j + 1]) {
                int temp = costs[j];
                costs[j] = costs[j + 1];
                costs[j + 1] = temp;
            }
        }
    }

    for (i = 0; i < costsSize; i++) {
        if (coins >= costs[i]) {
            coins -= costs[i];
            count++;
        } else {
            break;
        }
    }

    return count;
}