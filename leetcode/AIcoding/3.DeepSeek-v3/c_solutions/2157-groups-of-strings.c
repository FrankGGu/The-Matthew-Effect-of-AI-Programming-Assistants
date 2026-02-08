int* groupStrings(char ** words, int wordsSize, int* returnSize) {
    int *res = malloc(2 * sizeof(int));
    res[0] = 0;
    res[1] = 0;
    *returnSize = 2;

    int n = wordsSize;
    int *masks = malloc(n * sizeof(int));
    int *counts = calloc(1 << 26, sizeof(int));

    for (int i = 0; i < n; i++) {
        int mask = 0;
        char *word = words[i];
        int len = strlen(word);
        for (int j = 0; j < len; j++) {
            mask |= 1 << (word[j] - 'a');
        }
        masks[i] = mask;
        counts[mask]++;
    }

    int *visited = calloc(1 << 26, sizeof(int));
    int *queue = malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        int mask = masks[i];
        if (counts[mask] == 0 || visited[mask]) continue;

        int front = 0, rear = 0;
        queue[rear++] = mask;
        visited[mask] = 1;
        int groupSize = 0;

        while (front < rear) {
            int curr = queue[front++];
            groupSize += counts[curr];
            counts[curr] = 0;

            for (int j = 0; j < 26; j++) {
                int next = curr ^ (1 << j);
                if (counts[next] > 0 && !visited[next]) {
                    visited[next] = 1;
                    queue[rear++] = next;
                }
            }

            for (int j = 0; j < 26; j++) {
                if (curr & (1 << j)) {
                    for (int k = 0; k < 26; k++) {
                        if (!(curr & (1 << k))) {
                            int next = curr ^ (1 << j) ^ (1 << k);
                            if (counts[next] > 0 && !visited[next]) {
                                visited[next] = 1;
                                queue[rear++] = next;
                            }
                        }
                    }
                }
            }
        }

        res[0]++;
        if (groupSize > res[1]) {
            res[1] = groupSize;
        }
    }

    free(masks);
    free(counts);
    free(visited);
    free(queue);

    return res;
}