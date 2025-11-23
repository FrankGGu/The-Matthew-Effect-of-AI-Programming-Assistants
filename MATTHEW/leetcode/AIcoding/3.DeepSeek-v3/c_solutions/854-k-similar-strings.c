int kSimilarity(char* s1, char* s2) {
    int len = strlen(s1);
    char *queue[100000];
    int front = 0, rear = 0;
    int visited[300000] = {0};

    queue[rear++] = strdup(s1);
    visited[0] = 1;
    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            char* curr = queue[front++];
            if (strcmp(curr, s2) == 0) {
                for (int j = 0; j < rear; j++) {
                    free(queue[j]);
                }
                return steps;
            }

            int j = 0;
            while (j < len && curr[j] == s2[j]) j++;

            for (int k = j + 1; k < len; k++) {
                if (curr[k] == s2[j] && curr[k] != s2[k]) {
                    char* next = strdup(curr);
                    char temp = next[j];
                    next[j] = next[k];
                    next[k] = temp;

                    int hash = 0;
                    for (int h = 0; h < len; h++) {
                        hash = hash * 27 + (next[h] - 'a' + 1);
                        hash %= 300000;
                    }

                    if (!visited[hash]) {
                        visited[hash] = 1;
                        queue[rear++] = next;
                    } else {
                        free(next);
                    }
                }
            }
            free(curr);
        }
        steps++;
    }
    return -1;
}