int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int* parent, int* rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

bool* friendRequests(int n, int** restrictions, int restrictionsSize, int* restrictionsColSize, int** requests, int requestsSize, int* requestsColSize, int* returnSize) {
    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    bool* result = (bool*)malloc(requestsSize * sizeof(bool));
    *returnSize = requestsSize;

    for (int i = 0; i < requestsSize; i++) {
        int u = requests[i][0];
        int v = requests[i][1];
        int rootU = find(parent, u);
        int rootV = find(parent, v);

        if (rootU == rootV) {
            result[i] = true;
            continue;
        }

        bool valid = true;
        for (int j = 0; j < restrictionsSize; j++) {
            int x = restrictions[j][0];
            int y = restrictions[j][1];
            int rootX = find(parent, x);
            int rootY = find(parent, y);

            if ((rootU == rootX && rootV == rootY) || (rootU == rootY && rootV == rootX)) {
                valid = false;
                break;
            }
        }

        if (valid) {
            unionSet(parent, rank, u, v);
            result[i] = true;
        } else {
            result[i] = false;
        }
    }

    free(parent);
    free(rank);
    return result;
}