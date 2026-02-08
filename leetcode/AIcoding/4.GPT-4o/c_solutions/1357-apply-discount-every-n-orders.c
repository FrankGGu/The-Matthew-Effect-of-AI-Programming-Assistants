#define MAX_SIZE 10000

int[] applyDiscount(int* prices, int pricesSize, int n, int discount) {
    int* result = (int*)malloc(pricesSize * sizeof(int));

    for (int i = 0; i < pricesSize; i++) {
        if ((i + 1) % n == 0) {
            result[i] = prices[i] - discount;
            if (result[i] < 0) result[i] = 0;
        } else {
            result[i] = prices[i];
        }
    }

    return result;
}