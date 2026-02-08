char* smallestEquivalentString(char* s1, char* s2, char* baseStr) {
    int parent[26];
    for (int i = 0; i < 26; i++) {
        parent[i] = i;
    }

    for (int i = 0; s1[i] != '\0'; i++) {
        int a = s1[i] - 'a';
        int b = s2[i] - 'a';

        int rootA = a;
        while (parent[rootA] != rootA) {
            rootA = parent[rootA];
        }

        int rootB = b;
        while (parent[rootB] != rootB) {
            rootB = parent[rootB];
        }

        if (rootA < rootB) {
            parent[rootB] = rootA;
        } else {
            parent[rootA] = rootB;
        }
    }

    for (int i = 0; i < 26; i++) {
        int root = i;
        while (parent[root] != root) {
            root = parent[root];
        }
        parent[i] = root;
    }

    int len = strlen(baseStr);
    char* result = (char*)malloc(len + 1);
    for (int i = 0; i < len; i++) {
        int idx = baseStr[i] - 'a';
        result[i] = parent[idx] + 'a';
    }
    result[len] = '\0';

    return result;
}