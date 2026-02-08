int maxProfit(int* prices, int pricesSize) {
    if (pricesSize == 0) return 0;

    int sell = 0, buy = -prices[0], cooldown = 0;

    for (int i = 1; i < pricesSize; i++) {
        int prev_sell = sell;
        sell = buy + prices[i];
        buy = (cooldown - prices[i] > buy) ? cooldown - prices[i] : buy;
        cooldown = prev_sell;
    }

    return sell > cooldown ? sell : cooldown;
}