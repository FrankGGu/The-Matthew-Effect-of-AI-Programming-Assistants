int numWays(char* s) {
    long long mod = 1e9 + 7;
    int n = strlen(s);
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '1') count++;
    }

    if (count % 3 != 0) return 0;
    if (count == 0) return (long long)(n - 1) * (n - 2) / 2 % mod;

    int target = count / 3;
    long long firstCut = 0, secondCut = 0;
    int current = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '1') current++;
        if (current == target) firstCut++;
        else if (current == 2 * target) secondCut++;
    }

    return firstCut * secondCut % mod;
}