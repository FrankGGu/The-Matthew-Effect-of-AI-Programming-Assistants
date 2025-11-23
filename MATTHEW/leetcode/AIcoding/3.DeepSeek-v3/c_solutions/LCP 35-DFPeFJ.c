typedef struct {
    int node;
    int fuel;
    int cost;
} State;

typedef struct {
    int size;
    int capacity;
    State* data;
} PriorityQueue;

PriorityQueue* createPriorityQueue(int capacity) {
    PriorityQueue* pq = (PriorityQueue*)malloc(sizeof(PriorityQueue));
    pq->size = 0;
    pq->capacity = capacity;
    pq->data = (State*)malloc(capacity * sizeof(State));
    return pq;
}

void swap(State* a, State* b) {
    State temp = *a;
    *a = *b;
    *b = temp;
}

void push(PriorityQueue* pq, State state) {
    if (pq->size >= pq->capacity) return;
    pq->data[pq->size] = state;
    int current = pq->size;
    pq->size++;
    while (current > 0) {
        int parent = (current - 1) / 2;
        if (pq->data[parent].cost <= pq->data[current].cost) break;
        swap(&pq->data[parent], &pq->data[current]);
        current = parent;
    }
}

State pop(PriorityQueue* pq) {
    State result = pq->data[0];
    pq->size--;
    pq->data[0] = pq->data[pq->size];
    int current = 0;
    while (current * 2 + 1 < pq->size) {
        int left = current * 2 + 1;
        int right = current * 2 + 2;
        int smallest = current;
        if (pq->data[left].cost < pq->data[smallest].cost) smallest = left;
        if (right < pq->size && pq->data[right].cost < pq->data[smallest].cost) smallest = right;
        if (smallest == current) break;
        swap(&pq->data[current], &pq->data[smallest]);
        current = smallest;
    }
    return result;
}

int electricCarPlan(int** paths, int pathsSize, int* pathsColSize, int cnt, int start, int end, int* charge, int chargeSize) {
    int n = chargeSize;
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) graph[i][j] = INT_MAX;
    }
    for (int i = 0; i < pathsSize; i++) {
        int u = paths[i][0];
        int v = paths[i][1];
        int w = paths[i][2];
        if (w < graph[u][v]) {
            graph[u][v] = w;
            graph[v][u] = w;
        }
    }

    int** dist = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dist[i] = (int*)malloc((cnt + 1) * sizeof(int));
        for (int j = 0; j <= cnt; j++) dist[i][j] = INT_MAX;
    }
    dist[start][0] = 0;

    PriorityQueue* pq = createPriorityQueue(n * (cnt + 1) * 10);
    push(pq, (State){start, 0, 0});

    while (pq->size > 0) {
        State cur = pop(pq);
        int u = cur.node;
        int fuel = cur.fuel;
        int cost = cur.cost;
        if (cost > dist[u][fuel]) continue;
        if (u == end) return cost;

        if (fuel < cnt) {
            int newFuel = fuel + 1;
            int newCost = cost + charge[u];
            if (newCost < dist[u][newFuel]) {
                dist[u][newFuel] = newCost;
                push(pq, (State){u, newFuel, newCost});
            }
        }

        for (int v = 0; v < n; v++) {
            if (graph[u][v] != INT_MAX && fuel >= graph[u][v]) {
                int newFuel = fuel - graph[u][v];
                int newCost = cost + graph[u][v];
                if (newCost < dist[v][newFuel]) {
                    dist[v][newFuel] = newCost;
                    push(pq, (State){v, newFuel, newCost});
                }
            }
        }
    }

    for (int i = 0; i < n; i++) free(graph[i]);
    free(graph);
    for (int i = 0; i < n; i++) free(dist[i]);
    free(dist);
    free(pq->data);
    free(pq);

    return -1;
}