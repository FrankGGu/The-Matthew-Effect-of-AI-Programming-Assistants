int max(int a, int b) {
    return a > b ? a : b;
}

int mostProfitablePath(int** edges, int edgesSize, int* edgesColSize, int bob, int* amount, int amountSize) {
    int n = amountSize;
    int adj[n][n];
    int adjSize[n];
    memset(adjSize, 0, sizeof(adjSize));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adjSize[u]++] = v;
        adj[v][adjSize[v]++] = u;
    }

    int parent[n];
    int depth[n];
    memset(parent, -1, sizeof(parent));
    memset(depth, 0, sizeof(depth));

    int stack[n];
    int top = 0;
    stack[top++] = 0;
    parent[0] = -1;
    depth[0] = 0;

    while (top > 0) {
        int node = stack[--top];
        for (int i = 0; i < adjSize[node]; i++) {
            int neighbor = adj[node][i];
            if (neighbor != parent[node]) {
                parent[neighbor] = node;
                depth[neighbor] = depth[node] + 1;
                stack[top++] = neighbor;
            }
        }
    }

    int bobPath[n];
    int bobLen = 0;
    int cur = bob;
    while (cur != -1) {
        bobPath[bobLen++] = cur;
        cur = parent[cur];
    }

    int bobTime[n];
    for (int i = 0; i < n; i++) {
        bobTime[i] = -1;
    }
    for (int i = 0; i < bobLen; i++) {
        bobTime[bobPath[i]] = i;
    }

    int stack2[n];
    int top2 = 0;
    stack2[top2++] = 0;
    int aliceTime[n];
    for (int i = 0; i < n; i++) {
        aliceTime[i] = -1;
    }
    aliceTime[0] = 0;

    int maxProfit = -1000000000;

    while (top2 > 0) {
        int node = stack2[--top2];
        int isLeaf = 1;
        for (int i = 0; i < adjSize[node]; i++) {
            int neighbor = adj[node][i];
            if (neighbor != parent[node]) {
                aliceTime[neighbor] = aliceTime[node] + 1;
                stack2[top2++] = neighbor;
                isLeaf = 0;
            }
        }

        if (isLeaf) {
            int profit = 0;
            for (int i = 0; i < n; i++) {
                if (aliceTime[i] == -1) continue;
                if (bobTime[i] == -1 || aliceTime[i] < bobTime[i]) {
                    profit += amount[i];
                } else if (aliceTime[i] == bobTime[i]) {
                    profit += amount[i] / 2;
                }
            }
            if (profit > maxProfit) {
                maxProfit = profit;
            }
        }
    }

    return maxProfit;
}