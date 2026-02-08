#define MOD 1000000007

int dfs(int* locations, int locationsSize, int start, int finish, int fuel, int** memo) {
    if (fuel < 0) return 0;
    if (memo[start][fuel] != -1) return memo[start][fuel];
    int count = (start == finish) ? 1 : 0;

    for (int next = 0; next < locationsSize; next++) {
        if (next != start) {
            count = (count + dfs(locations, locationsSize, next, finish, fuel - abs(locations[start] - locations[next]), memo)) % MOD;
        }
    }

    return memo[start][fuel] = count;
}

int countRoutes(int* locations, int locationsSize, int start, int finish, int fuel) {
    int** memo = (int**)malloc(locationsSize * sizeof(int*));
    for (int i = 0; i < locationsSize; i++) {
        memo[i] = (int*)malloc((fuel + 1) * sizeof(int));
        for (int j = 0; j <= fuel; j++) {
            memo[i][j] = -1;
        }
    }
    int result = dfs(locations, locationsSize, start, finish, fuel, memo);

    for (int i = 0; i < locationsSize; i++) {
        free(memo[i]);
    }
    free(memo);

    return result;
}