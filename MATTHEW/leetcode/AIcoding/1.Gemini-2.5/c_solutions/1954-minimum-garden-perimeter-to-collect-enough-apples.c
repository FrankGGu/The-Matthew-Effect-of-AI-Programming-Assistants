long long minimumPerimeter(long long neededApples) {
    long long L = 0;
    while (1) {
        L++;
        // Calculate total apples for a garden with side length 2L
        // Total apples = 2 * L * (L + 1) * (2 * L + 1)
        // Ensure calculations use long long to prevent overflow
        unsigned long long currentTotalApples = (unsigned long long)2 * L * (L + 1) * (2 * L + 1);

        if (currentTotalApples >= neededApples) {
            return 8 * L;
        }
    }
}