int n;
int** g;
int** dp;
int** path;
int* best_path;
int best_len;

int calc_overlap(char* a, char* b) {
    int la = strlen(a), lb = strlen(b);
    int max_len = (la < lb) ? la : lb;
    for (int k = max_len; k >= 1; k--) {
        if (strncmp(a + la - k, b, k) == 0) {
            return k;
        }
    }
    return 0;
}

void dfs(int state, int last, int* cur_path, int cur_len, int cur_cost) {
    if (cur_cost >= best_len) return;
    if (state == (1 << n) - 1) {
        best_len = cur_cost;
        for (int i = 0; i < n; i++) best_path[i] = cur_path[i];
        return;
    }
    for (int i = 0; i < n; i++) {
        if (state & (1 << i)) continue;
        int new_state = state | (1 << i);
        int new_cost = cur_cost + (last == -1 ? strlen(g[i][i]) : g[last][i]);
        if (dp[new_state][i] > new_cost) {
            dp[new_state][i] = new_cost;
            path[new_state][i] = last;
            cur_path[cur_len] = i;
            dfs(new_state, i, cur_path, cur_len + 1, new_cost);
        }
    }
}

char* shortestSuperstring(char** words, int wordsSize) {
    n = wordsSize;
    if (n == 0) return strdup("");
    if (n == 1) return strdup(words[0]);

    g = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        g[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            if (i == j) {
                g[i][j] = strlen(words[i]);
            } else {
                g[i][j] = strlen(words[j]) - calc_overlap(words[i], words[j]);
            }
        }
    }

    int total_states = 1 << n;
    dp = (int**)malloc(total_states * sizeof(int*));
    path = (int**)malloc(total_states * sizeof(int*));
    for (int i = 0; i < total_states; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        path[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dp[i][j] = INT_MAX;
            path[i][j] = -1;
        }
    }

    best_path = (int*)malloc(n * sizeof(int));
    int* cur_path = (int*)malloc(n * sizeof(int));
    best_len = INT_MAX;

    for (int i = 0; i < n; i++) {
        int state = 1 << i;
        dp[state][i] = strlen(words[i]);
        path[state][i] = -1;
        cur_path[0] = i;
        dfs(state, i, cur_path, 1, dp[state][i]);
    }

    int* order = (int*)malloc(n * sizeof(int));
    int state = (1 << n) - 1;
    int last = -1;
    int min_cost = INT_MAX;
    for (int i = 0; i < n; i++) {
        if (dp[state][i] < min_cost) {
            min_cost = dp[state][i];
            last = i;
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        order[i] = last;
        int prev_state = state ^ (1 << last);
        last = path[state][last];
        state = prev_state;
    }

    char* result = (char*)malloc(1000 * sizeof(char));
    strcpy(result, words[order[0]]);
    for (int i = 1; i < n; i++) {
        int overlap = calc_overlap(words[order[i - 1]], words[order[i]]);
        strcat(result, words[order[i]] + overlap);
    }

    for (int i = 0; i < n; i++) free(g[i]);
    free(g);
    for (int i = 0; i < total_states; i++) {
        free(dp[i]);
        free(path[i]);
    }
    free(dp);
    free(path);
    free(best_path);
    free(cur_path);
    free(order);

    return result;
}