int maxProfit(int* prices, int pricesSize, int fee) {
    int cash = 0, hold = -prices[0];
    for (int i = 1; i < pricesSize; i++) {
        cash = fmax(cash, hold + prices[i] - fee);
        hold = fmax(hold, cash - prices[i]);
    }
    return cash;
}