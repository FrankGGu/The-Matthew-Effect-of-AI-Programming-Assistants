#define MOD 1000000007

int countHousePlacements(int n) {
    long long a = 1, b = 1;
    for (int i = 0; i < n; i++) {
        long long temp = a;
        a = (a + b) % MOD;
        b = temp;
    }
    return (int)((a * a) % MOD);
}