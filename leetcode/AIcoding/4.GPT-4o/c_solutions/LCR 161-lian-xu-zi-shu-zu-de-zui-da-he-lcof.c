int maxSalesDays(int* sales, int salesSize) {
    int maxDays = 0, currentDays = 0;

    for (int i = 0; i < salesSize; i++) {
        if (sales[i] > 0) {
            currentDays++;
            if (currentDays > maxDays) {
                maxDays = currentDays;
            }
        } else {
            currentDays = 0;
        }
    }

    return maxDays;
}