int maximumScore(int a, int b, int c) {
    int max = a > b ? (a > c ? a : c) : (b > c ? b : c);
    int sum = a + b + c;
    if (sum - max <= max) {
        return sum - max;
    } else {
        return sum / 2;
    }
}