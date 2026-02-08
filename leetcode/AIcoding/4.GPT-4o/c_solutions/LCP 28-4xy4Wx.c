#define MOD 1000000007

int waysToBuyPensPencils(int total, int cost1, int cost2) {
    long long res = 0;
    for (int i = 0; i <= total; i += cost1) {
        res = (res + (total - i) / cost2 + 1) % MOD;
    }
    return (int)res;
}