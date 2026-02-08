int countCombinations(int n, int k) {
    if (k == 0) return 1;
    if (k > n) return 0;

    long long res = 1;
    for (int i = 0; i < k; i++) {
        res = res * (n - i) / (i + 1);
    }

    return (int)res;
}

int numOfCombinations(int n, int k) {
    return countCombinations(n, k);
}