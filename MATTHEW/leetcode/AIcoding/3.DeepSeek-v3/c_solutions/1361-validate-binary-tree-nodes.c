int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

bool unionSet(int* parent, int* rank, int x, int y) {
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

bool validateBinaryTreeNodes(int n, int* leftChild, int leftChildSize, int* rightChild, int rightChildSize) {
    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)malloc(n * sizeof(int));
    int* indegree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        if (leftChild[i] != -1) {
            indegree[leftChild[i]]++;
            if (!unionSet(parent, rank, i, leftChild[i])) {
                free(parent);
                free(rank);
                free(indegree);
                return false;
            }
        }
        if (rightChild[i] != -1) {
            indegree[rightChild[i]]++;
            if (!unionSet(parent, rank, i, rightChild[i])) {
                free(parent);
                free(rank);
                free(indegree);
                return false;
            }
        }
    }

    int root = -1;
    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) {
            if (root == -1) {
                root = i;
            } else {
                free(parent);
                free(rank);
                free(indegree);
                return false;
            }
        } else if (indegree[i] > 1) {
            free(parent);
            free(rank);
            free(indegree);
            return false;
        }
    }

    if (root == -1) {
        free(parent);
        free(rank);
        free(indegree);
        return false;
    }

    int components = 0;
    for (int i = 0; i < n; i++) {
        if (find(parent, i) == i) {
            components++;
        }
    }

    free(parent);
    free(rank);
    free(indegree);

    return components == 1;
}