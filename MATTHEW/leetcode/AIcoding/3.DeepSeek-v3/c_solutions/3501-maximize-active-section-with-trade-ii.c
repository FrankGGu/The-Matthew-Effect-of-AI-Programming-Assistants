int maxActiveSections(int* prices, int pricesSize, int k) {
    int n = pricesSize;
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));

    int minPrice = prices[0];
    left[0] = 0;
    for (int i = 1; i < n; i++) {
        minPrice = (prices[i] < minPrice) ? prices[i] : minPrice;
        left[i] = (prices[i] - minPrice > left[i-1]) ? prices[i] - minPrice : left[i-1];
    }

    int maxPrice = prices[n-1];
    right[n-1] = 0;
    for (int i = n-2; i >= 0; i--) {
        maxPrice = (prices[i] > maxPrice) ? prices[i] : maxPrice;
        right[i] = (maxPrice - prices[i] > right[i+1]) ? maxPrice - prices[i] : right[i+1];
    }

    int maxProfit = 0;
    for (int i = 0; i < n - 1; i++) {
        int profit = left[i] + right[i+1];
        if (profit > maxProfit) {
            maxProfit = profit;
        }
    }

    free(left);
    free(right);

    return (maxProfit > k) ? maxProfit : 0;
}