int alienOrder(char** words, int wordsSize, char* order) {
    int graph[26][26] = {0};
    int indegree[26] = {0};
    int exists[26] = {0};

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; words[i][j]; j++) {
            exists[words[i][j] - 'a'] = 1;
        }
    }

    for (int i = 0; i < wordsSize - 1; i++) {
        char* w1 = words[i];
        char* w2 = words[i + 1];
        int len1 = strlen(w1);
        int len2 = strlen(w2);
        int found = 0;
        for (int j = 0; j < len1 && j < len2; j++) {
            if (w1[j] != w2[j]) {
                int u = w1[j] - 'a';
                int v = w2[j] - 'a';
                if (graph[u][v] == 0) {
                    graph[u][v] = 1;
                    indegree[v]++;
                }
                found = 1;
                break;
            }
        }
        if (!found && len1 > len2) {
            return 0;
        }
    }

    int queue[26];
    int front = 0, rear = 0;
    for (int i = 0; i < 26; i++) {
        if (exists[i] && indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int count = 0;
    while (front < rear) {
        int u = queue[front++];
        order[count++] = u + 'a';
        for (int v = 0; v < 26; v++) {
            if (graph[u][v]) {
                indegree[v]--;
                if (indegree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }

    order[count] = '\0';
    for (int i = 0; i < 26; i++) {
        if (exists[i] && indegree[i] > 0) {
            return 0;
        }
    }
    return 1;
}