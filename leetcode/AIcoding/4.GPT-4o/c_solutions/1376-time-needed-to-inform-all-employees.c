int numOfMinutes(int n, int headID, int *manager, int *informTime, int managerSize) {
    int **tree = (int **)malloc(n * sizeof(int *));
    for (int i = 0; i < n; i++) {
        tree[i] = (int *)malloc(n * sizeof(int));
        tree[i][0] = 0;
    }

    for (int i = 0; i < n; i++) {
        if (manager[i] != -1) {
            tree[manager[i]][tree[manager[i]][0] + 1] = i;
            tree[manager[i]][0]++;
        }
    }

    int maxTime = 0;

    void dfs(int id, int currentTime) {
        currentTime += informTime[id];
        maxTime = (currentTime > maxTime) ? currentTime : maxTime;
        for (int i = 1; i <= tree[id][0]; i++) {
            dfs(tree[id][i], currentTime);
        }
    }

    dfs(headID, 0);

    for (int i = 0; i < n; i++) {
        free(tree[i]);
    }
    free(tree);

    return maxTime;
}