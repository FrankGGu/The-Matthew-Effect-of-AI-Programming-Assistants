#define MAXN 100005
#define MOD 1000000007

typedef long long ll;

ll maxWeightSum(int n, int edges[][3], int edgesSize) {
    ll dp[MAXN] = {0};
    ll totalWeight = 0;

    for (int i = 0; i < edgesSize; i++) {
        totalWeight = (totalWeight + edges[i][2]) % MOD;
    }

    // Build the graph
    ll graph[MAXN][MAXN] = {0};
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        ll w = edges[i][2];
        graph[u][v] = w;
        graph[v][u] = w;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            if (graph[i][j] > 0) {
                dp[i] = (dp[i] + graph[i][j]) % MOD;
            }
        }
    }

    ll maxWeight = 0;
    for (int i = 1; i <= n; i++) {
        maxWeight = (maxWeight + dp[i]) % MOD;
    }

    return (totalWeight - maxWeight + MOD) % MOD;
}