int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

bool unionSets(int* parent, int* rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX == rootY) return false;
    if (rank[rootX] < rank[rootY]) {
        parent[rootX] = rootY;
    } else if (rank[rootX] > rank[rootY]) {
        parent[rootY] = rootX;
    } else {
        parent[rootY] = rootX;
        rank[rootX]++;
    }
    return true;
}

int maxNumEdgesToRemove(int n, int** edges, int edgesSize, int* edgesColSize) {
    int* parentA = (int*)malloc((n + 1) * sizeof(int));
    int* rankA = (int*)malloc((n + 1) * sizeof(int));
    int* parentB = (int*)malloc((n + 1) * sizeof(int));
    int* rankB = (int*)malloc((n + 1) * sizeof(int));

    for (int i = 1; i <= n; i++) {
        parentA[i] = i;
        rankA[i] = 0;
        parentB[i] = i;
        rankB[i] = 0;
    }

    int used = 0;

    for (int i = 0; i < edgesSize; i++) {
        if (edges[i][0] == 3) {
            if (unionSets(parentA, rankA, edges[i][1], edges[i][2])) {
                unionSets(parentB, rankB, edges[i][1], edges[i][2]);
                used++;
            }
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        if (edges[i][0] == 1) {
            if (unionSets(parentA, rankA, edges[i][1], edges[i][2])) {
                used++;
            }
        } else if (edges[i][0] == 2) {
            if (unionSets(parentB, rankB, edges[i][1], edges[i][2])) {
                used++;
            }
        }
    }

    int rootA = find(parentA, 1);
    for (int i = 2; i <= n; i++) {
        if (find(parentA, i) != rootA) {
            free(parentA);
            free(rankA);
            free(parentB);
            free(rankB);
            return -1;
        }
    }

    int rootB = find(parentB, 1);
    for (int i = 2; i <= n; i++) {
        if (find(parentB, i) != rootB) {
            free(parentA);
            free(rankA);
            free(parentB);
            free(rankB);
            return -1;
        }
    }

    free(parentA);
    free(rankA);
    free(parentB);
    free(rankB);

    return edgesSize - used;
}