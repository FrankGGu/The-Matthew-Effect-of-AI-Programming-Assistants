int dfs(char** strs, int visited[], int index, int size) {
    visited[index] = 1;
    for (int i = 0; i < size; i++) {
        if (!visited[i]) {
            int diff = 0;
            for (int j = 0; j < strlen(strs[index]); j++) {
                if (strs[index][j] != strs[i][j]) {
                    diff++;
                }
            }
            if (diff == 2 || diff == 0) {
                dfs(strs, visited, i, size);
            }
        }
    }
}

int numSimilarGroups(char** strs, int strsSize) {
    int* visited = (int*)malloc(sizeof(int) * strsSize);
    memset(visited, 0, sizeof(int) * strsSize);
    int groups = 0;

    for (int i = 0; i < strsSize; i++) {
        if (!visited[i]) {
            dfs(strs, visited, i, strsSize);
            groups++;
        }
    }

    free(visited);
    return groups;
}