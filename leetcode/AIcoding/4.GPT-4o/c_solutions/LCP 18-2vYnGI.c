int numCombinations(int low, int high, int zero, int one) {
    int count = 0;
    for (int i = low; i <= high; i++) {
        if (i % zero == 0 && (i / zero) % one == 0) {
            count++;
        }
    }
    return count;
}