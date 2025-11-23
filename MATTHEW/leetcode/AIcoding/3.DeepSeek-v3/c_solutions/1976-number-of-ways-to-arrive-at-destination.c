typedef long long ll;

int countPaths(int n, int** roads, int roadsSize, int* roadsColSize) {
    ll MOD = 1e9 + 7;
    ll INF = 1e18;

    ll** graph = (ll**)malloc(n * sizeof(ll*));
    for (int i = 0; i < n; i++) {
        graph[i] = (ll*)malloc(n * sizeof(ll));
        for (int j = 0; j < n; j++) {
            graph[i][j] = INF;
        }
        graph[i][i] = 0;
    }

    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];
        ll time = roads[i][2];
        graph[u][v] = time;
        graph[v][u] = time;
    }

    ll* dist = (ll*)malloc(n * sizeof(ll));
    ll* ways = (ll*)malloc(n * sizeof(ll));
    int* visited = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        dist[i] = INF;
        ways[i] = 0;
        visited[i] = 0;
    }

    dist[0] = 0;
    ways[0] = 1;

    for (int i = 0; i < n; i++) {
        int u = -1;
        for (int j = 0; j < n; j++) {
            if (!visited[j] && (u == -1 || dist[j] < dist[u])) {
                u = j;
            }
        }

        if (dist[u] == INF) break;
        visited[u] = 1;

        for (int v = 0; v < n; v++) {
            if (graph[u][v] == INF) continue;

            ll newDist = dist[u] + graph[u][v];
            if (newDist < dist[v]) {
                dist[v] = newDist;
                ways[v] = ways[u];
            } else if (newDist == dist[v]) {
                ways[v] = (ways[v] + ways[u]) % MOD;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(dist);
    free(visited);

    return ways[n-1] % MOD;
}