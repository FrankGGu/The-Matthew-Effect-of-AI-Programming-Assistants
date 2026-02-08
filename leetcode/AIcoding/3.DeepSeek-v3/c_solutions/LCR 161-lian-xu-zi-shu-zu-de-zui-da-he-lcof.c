int maxSales(int* sales, int salesSize) {
    int max = sales[0];
    int current = sales[0];

    for (int i = 1; i < salesSize; i++) {
        if (current < 0) {
            current = sales[i];
        } else {
            current += sales[i];
        }

        if (current > max) {
            max = current;
        }
    }

    return max;
}