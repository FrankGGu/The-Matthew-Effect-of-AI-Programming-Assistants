int maxProfit(int* prices, int pricesSize) {
    if (pricesSize <= 1) return 0;

    int* buy = (int*)malloc(pricesSize * sizeof(int));
    int* sell = (int*)malloc(pricesSize * sizeof(int));
    int* cooldown = (int*)malloc(pricesSize * sizeof(int));

    buy[0] = -prices[0];
    sell[0] = 0;
    cooldown[0] = 0;

    for (int i = 1; i < pricesSize; i++) {
        buy[i] = (cooldown[i-1] - prices[i]) > buy[i-1] ? (cooldown[i-1] - prices[i]) : buy[i-1];
        sell[i] = (buy[i-1] + prices[i]) > sell[i-1] ? (buy[i-1] + prices[i]) : sell[i-1];
        cooldown[i] = sell[i-1] > cooldown[i-1] ? sell[i-1] : cooldown[i-1];
    }

    int result = sell[pricesSize-1] > cooldown[pricesSize-1] ? sell[pricesSize-1] : cooldown[pricesSize-1];

    free(buy);
    free(sell);
    free(cooldown);

    return result;
}