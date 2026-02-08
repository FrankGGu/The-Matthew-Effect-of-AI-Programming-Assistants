#define MOD 1000000007

int countWays(int n, int* edges, int edgesSize) {
    long long result = 1;
    for (int i = 0; i < edgesSize; i++) {
        result = (result * 3) % MOD;
    }
    return (int)result;
}