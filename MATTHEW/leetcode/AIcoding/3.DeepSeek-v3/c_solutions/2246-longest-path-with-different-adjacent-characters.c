int maxPath;

int dfs(int node, char* s, int** children, int* childrenSize) {
    int max1 = 0, max2 = 0;

    for (int i = 0; i < childrenSize[node]; i++) {
        int child = children[node][i];
        int childPath = dfs(child, s, children, childrenSize);

        if (s[node] != s[child]) {
            if (childPath > max1) {
                max2 = max1;
                max1 = childPath;
            } else if (childPath > max2) {
                max2 = childPath;
            }
        }
    }

    maxPath = maxPath > (max1 + max2 + 1) ? maxPath : (max1 + max2 + 1);
    return max1 + 1;
}

int longestPath(int* parent, int parentSize, char* s) {
    maxPath = 1;
    int n = parentSize;

    int** children = (int**)malloc(n * sizeof(int*));
    int* childrenSize = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        children[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 1; i < n; i++) {
        int p = parent[i];
        children[p][childrenSize[p]++] = i;
    }

    dfs(0, s, children, childrenSize);

    for (int i = 0; i < n; i++) {
        free(children[i]);
    }
    free(children);
    free(childrenSize);

    return maxPath;
}