int maximumScore(int a, int b, int c) {
    int sum = a + b + c;
    int maxScore = sum / 3;
    return sum % 3 == 0 ? maxScore : maxScore + 1;
}