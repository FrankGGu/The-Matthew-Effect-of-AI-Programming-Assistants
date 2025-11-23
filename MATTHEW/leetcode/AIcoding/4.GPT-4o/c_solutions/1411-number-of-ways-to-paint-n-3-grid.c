#define MOD 1000000007

int numOfWays(int n) {
    long long a = 6, b = 6;
    for (int i = 1; i < n; i++) {
        long long temp = b;
        b = (2 * a + 3 * b) % MOD;
        a = temp;
    }
    return (int)b;
}