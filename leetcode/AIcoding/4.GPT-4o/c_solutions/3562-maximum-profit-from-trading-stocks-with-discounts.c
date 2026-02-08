int maxProfit(int* prices, int pricesSize) {
    if (pricesSize == 0) return 0;

    int maxProfit = 0;
    int minPrice = prices[0];

    for (int i = 1; i < pricesSize; i++) {
        if (prices[i] < minPrice) {
            minPrice = prices[i];
        } else {
            int profit = prices[i] - minPrice;
            if (i > 1 && prices[i] < prices[i - 1]) {
                profit -= 1; // applying discount
            }
            if (profit > maxProfit) {
                maxProfit = profit;
            }
        }
    }

    return maxProfit;
}