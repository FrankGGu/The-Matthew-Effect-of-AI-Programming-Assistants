typedef struct {
    int node;
    double prob;
} Pair;

typedef struct {
    Pair* data;
    int size;
    int capacity;
} PriorityQueue;

PriorityQueue* createPriorityQueue(int capacity) {
    PriorityQueue* pq = (PriorityQueue*)malloc(sizeof(PriorityQueue));
    pq->data = (Pair*)malloc(capacity * sizeof(Pair));
    pq->size = 0;
    pq->capacity = capacity;
    return pq;
}

void swap(Pair* a, Pair* b) {
    Pair temp = *a;
    *a = *b;
    *b = temp;
}

void push(PriorityQueue* pq, int node, double prob) {
    if (pq->size == pq->capacity) return;

    pq->data[pq->size].node = node;
    pq->data[pq->size].prob = prob;
    int current = pq->size;
    pq->size++;

    while (current > 0) {
        int parent = (current - 1) / 2;
        if (pq->data[parent].prob >= pq->data[current].prob) break;
        swap(&pq->data[parent], &pq->data[current]);
        current = parent;
    }
}

Pair pop(PriorityQueue* pq) {
    Pair result = pq->data[0];
    pq->size--;
    pq->data[0] = pq->data[pq->size];

    int current = 0;
    while (1) {
        int left = 2 * current + 1;
        int right = 2 * current + 2;
        int largest = current;

        if (left < pq->size && pq->data[left].prob > pq->data[largest].prob)
            largest = left;
        if (right < pq->size && pq->data[right].prob > pq->data[largest].prob)
            largest = right;

        if (largest == current) break;
        swap(&pq->data[current], &pq->data[largest]);
        current = largest;
    }

    return result;
}

int isEmpty(PriorityQueue* pq) {
    return pq->size == 0;
}

void freePriorityQueue(PriorityQueue* pq) {
    free(pq->data);
    free(pq);
}

double maxProbability(int n, int** edges, int edgesSize, int* edgesColSize, double* succProb, int succProbSize, int start, int end) {
    double* dist = (double*)malloc(n * sizeof(double));
    for (int i = 0; i < n; i++) dist[i] = 0.0;
    dist[start] = 1.0;

    PriorityQueue* pq = createPriorityQueue(n);
    push(pq, start, 1.0);

    while (!isEmpty(pq)) {
        Pair current = pop(pq);
        int u = current.node;
        double prob_u = current.prob;

        if (u == end) {
            freePriorityQueue(pq);
            free(dist);
            return prob_u;
        }

        if (prob_u < dist[u]) continue;

        for (int i = 0; i < edgesSize; i++) {
            int v = -1;
            if (edges[i][0] == u) v = edges[i][1];
            else if (edges[i][1] == u) v = edges[i][0];

            if (v != -1) {
                double new_prob = prob_u * succProb[i];
                if (new_prob > dist[v]) {
                    dist[v] = new_prob;
                    push(pq, v, new_prob);
                }
            }
        }
    }

    freePriorityQueue(pq);
    double result = dist[end];
    free(dist);
    return result;
}