int fillCups(int* cups, int cupsSize) {
    int max1 = 0, max2 = 0;
    for (int i = 0; i < cupsSize; i++) {
        if (cups[i] > max1) {
            max2 = max1;
            max1 = cups[i];
        } else if (cups[i] > max2) {
            max2 = cups[i];
        }
    }
    return max1 + (max1 - max2 + 1) / 2;
}