typedef struct {
    int mod;
    long long* tree;
    int n;
} FenwickTree;

FenwickTree* createFenwickTree(int n, int mod) {
    FenwickTree* ft = (FenwickTree*)malloc(sizeof(FenwickTree));
    ft->mod = mod;
    ft->n = n;
    ft->tree = (long long*)calloc(n + 1, sizeof(long long));
    return ft;
}

void update(FenwickTree* ft, int index, int delta) {
    while (index <= ft->n) {
        ft->tree[index] = (ft->tree[index] + delta) % ft->mod;
        index += index & -index;
    }
}

long long query(FenwickTree* ft, int index) {
    long long sum = 0;
    while (index > 0) {
        sum = (sum + ft->tree[index]) % ft->mod;
        index -= index & -index;
    }
    return sum;
}

void freeFenwickTree(FenwickTree* ft) {
    free(ft->tree);
    free(ft);
}

int* bonus(int n, int** leadership, int leadershipSize, int* leadershipColSize, int** operations, int operationsSize, int* operationsColSize, int* returnSize) {
    int mod = 1000000007;

    int* graph[n + 1];
    int graphSize[n + 1];
    for (int i = 0; i <= n; i++) {
        graph[i] = (int*)malloc(0);
        graphSize[i] = 0;
    }

    for (int i = 0; i < leadershipSize; i++) {
        int a = leadership[i][0];
        int b = leadership[i][1];
        graphSize[a]++;
        graph[a] = (int*)realloc(graph[a], graphSize[a] * sizeof(int));
        graph[a][graphSize[a] - 1] = b;
    }

    int in[n + 1], out[n + 1];
    int time = 0;

    int stack[n + 1];
    int top = 0;
    stack[top++] = 1;

    while (top > 0) {
        int node = stack[--top];
        if (node > 0) {
            in[node] = ++time;
            stack[top++] = -node;
            for (int i = graphSize[node] - 1; i >= 0; i--) {
                stack[top++] = graph[node][i];
            }
        } else {
            out[-node] = time;
        }
    }

    for (int i = 0; i <= n; i++) {
        free(graph[i]);
    }

    FenwickTree* ft = createFenwickTree(n, mod);

    int* res = (int*)malloc(operationsSize * sizeof(int));
    int resSize = 0;

    for (int i = 0; i < operationsSize; i++) {
        int type = operations[i][0];
        int a = operations[i][1];
        if (type == 1) {
            int coins = operations[i][2];
            update(ft, in[a], coins);
        } else if (type == 2) {
            int coins = operations[i][2];
            update(ft, in[a], coins);
            if (out[a] < n) {
                update(ft, out[a] + 1, -coins);
            }
        } else {
            long long sum = (query(ft, out[a]) - query(ft, in[a] - 1) + mod) % mod;
            res[resSize++] = sum;
        }
    }

    freeFenwickTree(ft);

    *returnSize = resSize;
    return res;
}