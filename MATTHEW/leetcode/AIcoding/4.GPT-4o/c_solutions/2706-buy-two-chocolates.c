int maxChocolates(int* prices, int pricesSize, int money) {
    int maxChoco = 0;

    for (int i = 0; i < pricesSize; i++) {
        for (int j = i + 1; j < pricesSize; j++) {
            int cost = prices[i] + prices[j];
            if (cost <= money) {
                maxChoco = fmax(maxChoco, 2);
            }
        }
    }

    return maxChoco;
}