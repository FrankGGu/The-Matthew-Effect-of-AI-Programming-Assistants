int maxChocolates(int* chocolates, int chocolatesSize, int k) {
    int maxChoco = 0;
    for (int i = 0; i < chocolatesSize; i++) {
        if (i + k < chocolatesSize) {
            int total = 0;
            for (int j = i; j < i + k; j++) {
                total += chocolates[j];
            }
            if (total > maxChoco) {
                maxChoco = total;
            }
        }
    }
    return maxChoco;
}