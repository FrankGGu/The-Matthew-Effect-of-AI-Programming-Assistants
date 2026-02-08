int numOfWays(int n) {
    long mod = 1e9 + 7;
    long abc = 6, aba = 6;

    for (int i = 1; i < n; i++) {
        long new_abc = (abc * 2 + aba * 2) % mod;
        long new_aba = (abc * 2 + aba * 3) % mod;
        abc = new_abc;
        aba = new_aba;
    }

    return (abc + aba) % mod;
}