int numSimilarGroups(char ** strs, int strsSize) {
    int parent[1000];
    for (int i = 0; i < strsSize; i++) parent[i] = i;

    int find(int x) {
        if (parent[x] != x) parent[x] = find(parent[x]);
        return parent[x];
    }

    void unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) parent[rootX] = rootY;
    }

    bool areSimilar(char *s1, char *s2) {
        int diff = 0;
        for (int i = 0; s1[i]; i++) {
            if (s1[i] != s2[i]) {
                diff++;
                if (diff > 2) return false;
            }
        }
        return diff == 0 || diff == 2;
    }

    for (int i = 0; i < strsSize; i++) {
        for (int j = i + 1; j < strsSize; j++) {
            if (areSimilar(strs[i], strs[j])) {
                unionSet(i, j);
            }
        }
    }

    int groups = 0;
    for (int i = 0; i < strsSize; i++) {
        if (find(i) == i) groups++;
    }

    return groups;
}