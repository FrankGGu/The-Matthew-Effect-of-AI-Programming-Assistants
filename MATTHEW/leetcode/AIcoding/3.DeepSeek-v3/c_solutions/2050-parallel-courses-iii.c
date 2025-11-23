typedef struct {
    int *items;
    int front;
    int rear;
    int size;
} Queue;

Queue* createQueue(int size) {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->items = (int*)malloc(size * sizeof(int));
    q->front = 0;
    q->rear = -1;
    q->size = size;
    return q;
}

void enqueue(Queue *q, int value) {
    q->items[++q->rear] = value;
}

int dequeue(Queue *q) {
    return q->items[q->front++];
}

int isEmpty(Queue *q) {
    return q->front > q->rear;
}

int minimumTime(int n, int** relations, int relationsSize, int* relationsColSize, int* time, int timeSize) {
    int *indegree = (int*)calloc(n + 1, sizeof(int));
    int **graph = (int**)malloc((n + 1) * sizeof(int*));
    int *graphSize = (int*)calloc(n + 1, sizeof(int));

    for (int i = 0; i <= n; i++) {
        graph[i] = (int*)malloc(relationsSize * sizeof(int));
    }

    for (int i = 0; i < relationsSize; i++) {
        int u = relations[i][0];
        int v = relations[i][1];
        graph[u][graphSize[u]++] = v;
        indegree[v]++;
    }

    int *completionTime = (int*)calloc(n + 1, sizeof(int));
    Queue *q = createQueue(n);

    for (int i = 1; i <= n; i++) {
        if (indegree[i] == 0) {
            enqueue(q, i);
            completionTime[i] = time[i - 1];
        }
    }

    while (!isEmpty(q)) {
        int u = dequeue(q);

        for (int i = 0; i < graphSize[u]; i++) {
            int v = graph[u][i];
            if (completionTime[v] < completionTime[u] + time[v - 1]) {
                completionTime[v] = completionTime[u] + time[v - 1];
            }
            indegree[v]--;
            if (indegree[v] == 0) {
                enqueue(q, v);
            }
        }
    }

    int maxTime = 0;
    for (int i = 1; i <= n; i++) {
        if (completionTime[i] > maxTime) {
            maxTime = completionTime[i];
        }
    }

    for (int i = 0; i <= n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphSize);
    free(indegree);
    free(completionTime);
    free(q->items);
    free(q);

    return maxTime;
}