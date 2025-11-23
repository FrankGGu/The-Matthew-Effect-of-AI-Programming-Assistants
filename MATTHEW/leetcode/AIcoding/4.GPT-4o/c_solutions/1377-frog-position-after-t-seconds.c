#define MAXN 10001

typedef struct {
    int node;
    double prob;
} Pair;

double frogPosition(int n, int edgesSize, int** edges, int t, int target) {
    int graph[MAXN][MAXN] = {0};
    int degree[MAXN] = {0};
    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]][edges[i][1]] = 1;
        graph[edges[i][1]][edges[i][0]] = 1;
        degree[edges[i][0]]++;
        degree[edges[i][1]]++;
    }

    double dp[MAXN][MAXN] = {0};
    dp[1][0] = 1.0;

    for (int time = 1; time <= t; time++) {
        for (int node = 1; node <= n; node++) {
            if (dp[node][time - 1] > 0) {
                double prob = dp[node][time - 1] / degree[node];
                for (int next = 1; next <= n; next++) {
                    if (graph[node][next]) {
                        dp[next][time] += prob;
                    }
                }
            }
        }
    }

    double result = dp[target][t];
    for (int time = 0; time < t; time++) {
        if (dp[target][time] > 0) {
            return 0.0;
        }
    }

    return result;
}