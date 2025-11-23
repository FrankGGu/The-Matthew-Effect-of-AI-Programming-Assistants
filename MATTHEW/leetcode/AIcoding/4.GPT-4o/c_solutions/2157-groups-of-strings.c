int findGroup(char *s, int *parent) {
    int root = s[0] - 'a';
    while (parent[root] != -1) {
        root = parent[root];
    }
    return root;
}

void unionGroups(char *s, int *parent) {
    int root1 = s[0] - 'a';
    for (int i = 1; s[i] != '\0'; i++) {
        int root2 = s[i] - 'a';
        while (parent[root1] != -1) {
            root1 = parent[root1];
        }
        while (parent[root2] != -1) {
            root2 = parent[root2];
        }
        if (root1 != root2) {
            parent[root2] = root1;
        }
    }
}

int stringGroupCount(char **strings, int stringsSize) {
    int parent[26];
    for (int i = 0; i < 26; i++) {
        parent[i] = -1;
    }

    for (int i = 0; i < stringsSize; i++) {
        unionGroups(strings[i], parent);
    }

    int groups = 0;
    for (int i = 0; i < 26; i++) {
        if (parent[i] == -1) {
            groups++;
        }
    }

    return groups;
}

int numSimilarGroups(char **strs, int strsSize) {
    return stringGroupCount(strs, strsSize);
}