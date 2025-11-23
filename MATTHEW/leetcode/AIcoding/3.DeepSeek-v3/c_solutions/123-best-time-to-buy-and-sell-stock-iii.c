int maxProfit(int* prices, int pricesSize) {
    if (pricesSize <= 1) return 0;

    int buy1 = -prices[0], sell1 = 0;
    int buy2 = -prices[0], sell2 = 0;

    for (int i = 1; i < pricesSize; i++) {
        buy1 = (buy1 > -prices[i]) ? buy1 : -prices[i];
        sell1 = (sell1 > buy1 + prices[i]) ? sell1 : buy1 + prices[i];
        buy2 = (buy2 > sell1 - prices[i]) ? buy2 : sell1 - prices[i];
        sell2 = (sell2 > buy2 + prices[i]) ? sell2 : buy2 + prices[i];
    }

    return sell2;
}