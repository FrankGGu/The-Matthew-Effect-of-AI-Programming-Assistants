int commonFactors(int a, int b) {
    int count = 0;
    int min_ab = a < b ? a : b;
    for (int i = 1; i <= min_ab; i++) {
        if (a % i == 0 && b % i == 0) {
            count++;
        }
    }
    return count;
}