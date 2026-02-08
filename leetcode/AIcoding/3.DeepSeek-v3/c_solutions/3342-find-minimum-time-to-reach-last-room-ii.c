typedef struct {
    int time;
    int row;
    int col;
} Node;

int cmp(const void* a, const void* b) {
    return ((Node*)a)->time - ((Node*)b)->time;
}

int minTimeToReach(int** moveTime, int moveTimeSize, int* moveTimeColSize) {
    int m = moveTimeSize;
    int n = moveTimeColSize[0];

    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX;
        }
    }
    dist[0][0] = 0;

    Node* heap = (Node*)malloc(m * n * sizeof(Node));
    int heapSize = 0;

    heap[heapSize++] = (Node){0, 0, 0};

    int dirs[4][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}};

    while (heapSize > 0) {
        qsort(heap, heapSize, sizeof(Node), cmp);
        Node curr = heap[0];
        for (int i = 1; i < heapSize; i++) {
            heap[i-1] = heap[i];
        }
        heapSize--;

        int time = curr.time;
        int r = curr.row;
        int c = curr.col;

        if (r == m-1 && c == n-1) {
            for (int i = 0; i < m; i++) {
                free(dist[i]);
            }
            free(dist);
            free(heap);
            return time;
        }

        if (time > dist[r][c]) {
            continue;
        }

        for (int i = 0; i < 4; i++) {
            int nr = r + dirs[i][0];
            int nc = c + dirs[i][1];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                int waitTime = (moveTime[nr][nc] - time) % 2 == 0 ? 1 : 0;
                int newTime = fmax(time + 1, moveTime[nr][nc] + waitTime);

                if (newTime < dist[nr][nc]) {
                    dist[nr][nc] = newTime;
                    heap[heapSize++] = (Node){newTime, nr, nc};
                }
            }
        }
    }

    for (int i = 0; i < m; i++) {
        free(dist[i]);
    }
    free(dist);
    free(heap);

    return dist[m-1][n-1];
}