#define MAX_TIME 1000
#define MAX_NODES 1000
#define INF 1e9

typedef struct {
    int node, time, cost;
} State;

int minCost(int maxTime, int** edges, int edgesSize, int* edgesColSize, int* passingFees, int passingFeesSize) {
    int n = passingFeesSize;
    int** graph = (int**)malloc(n * sizeof(int*));
    int** timeGraph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        timeGraph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph[i][j] = -1;
            timeGraph[i][j] = -1;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1], t = edges[i][2], c = passingFees[v];
        if (graph[u][v] == -1 || t < timeGraph[u][v]) {
            graph[u][v] = c;
            timeGraph[u][v] = t;
            graph[v][u] = passingFees[u];
            timeGraph[v][u] = t;
        }
    }

    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc((maxTime + 1) * sizeof(int));
        for (int j = 0; j <= maxTime; j++) {
            dp[i][j] = INF;
        }
    }

    dp[0][0] = passingFees[0];

    for (int time = 0; time <= maxTime; time++) {
        for (int u = 0; u < n; u++) {
            if (dp[u][time] == INF) continue;
            for (int v = 0; v < n; v++) {
                if (graph[u][v] == -1) continue;
                int newTime = time + timeGraph[u][v];
                if (newTime > maxTime) continue;
                int newCost = dp[u][time] + graph[u][v];
                if (newCost < dp[v][newTime]) {
                    dp[v][newTime] = newCost;
                }
            }
        }
    }

    int ans = INF;
    for (int time = 0; time <= maxTime; time++) {
        if (dp[n-1][time] < ans) {
            ans = dp[n-1][time];
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
        free(timeGraph[i]);
        free(dp[i]);
    }
    free(graph);
    free(timeGraph);
    free(dp);

    return ans == INF ? -1 : ans;
}