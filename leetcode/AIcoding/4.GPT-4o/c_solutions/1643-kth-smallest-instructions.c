char* kthSmallestInstructions(int n, int k) {
    char* result = (char*)malloc((2 * n) + 1);
    int i = 0, j = 0;
    k--;

    for (int l = 0; l < 2 * n; l++) {
        int total = n - i + n - j;
        int leftCount = 1;
        int rightCount = 1;

        if (i < n) {
            leftCount = binomialCoefficient(n - i - 1 + n - j, n - j);
        }
        if (j < n) {
            rightCount = binomialCoefficient(n - i + n - j - 1, n - i);
        }

        if (k < leftCount) {
            result[l] = 'D';
            i++;
        } else {
            result[l] = 'R';
            k -= leftCount;
            j++;
        }
    }

    result[2 * n] = '\0';
    return result;
}

int binomialCoefficient(int n, int k) {
    if (k > n) return 0;
    if (k == 0 || k == n) return 1;
    k = k > n - k ? n - k : k;
    long long res = 1;
    for (int i = 0; i < k; i++) {
        res = res * (n - i) / (i + 1);
    }
    return (int)res;
}