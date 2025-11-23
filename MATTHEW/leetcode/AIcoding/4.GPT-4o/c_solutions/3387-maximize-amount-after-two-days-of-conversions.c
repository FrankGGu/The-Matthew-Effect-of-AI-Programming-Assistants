int maxAmount(int* amounts, int amountsSize) {
    if (amountsSize == 0) return 0;
    if (amountsSize == 1) return amounts[0];

    int max1 = 0, max2 = 0;

    for (int i = 0; i < amountsSize; i++) {
        if (i % 2 == 0) {
            max1 = fmax(max1 + amounts[i], max2);
        } else {
            max2 = fmax(max2 + amounts[i], max1);
        }
    }

    return fmax(max1, max2);
}