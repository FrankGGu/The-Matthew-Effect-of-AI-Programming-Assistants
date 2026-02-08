typedef struct {
    int node;
    long long dist;
} State;

typedef struct {
    int node, weight, idx;
} EdgeInfo;

int cmp(const void* a, const void* b) {
    State* s1 = (State*)a;
    State* s2 = (State*)b;
    if (s1->dist > s2->dist) return 1;
    if (s1->dist < s2->dist) return 1;
    return 0;
}

long long* dijkstra(int n, EdgeInfo** graph, int* graphColSize, int source) {
    long long* dist = malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) dist[i] = LLONG_MAX;
    dist[source] = 0;

    State* heap = malloc(n * sizeof(State));
    int heapSize = 0;

    heap[heapSize].node = source;
    heap[heapSize].dist = 0;
    heapSize++;

    while (heapSize > 0) {
        State cur = heap[0];
        heap[0] = heap[--heapSize];

        int i = 0;
        while (1) {
            int left = 2 * i + 1;
            int right = 2 * i + 2;
            int smallest = i;

            if (left < heapSize && heap[left].dist < heap[smallest].dist) smallest = left;
            if (right < heapSize && heap[right].dist < heap[smallest].dist) smallest = right;

            if (smallest == i) break;

            State temp = heap[i];
            heap[i] = heap[smallest];
            heap[smallest] = temp;
            i = smallest;
        }

        if (cur.dist > dist[cur.node]) continue;

        for (int j = 0; j < graphColSize[cur.node]; j++) {
            EdgeInfo edge = graph[cur.node][j];
            long long newDist = cur.dist + edge.weight;
            if (newDist < dist[edge.node]) {
                dist[edge.node] = newDist;
                heap[heapSize].node = edge.node;
                heap[heapSize].dist = newDist;
                heapSize++;

                int k = heapSize - 1;
                while (k > 0 && heap[(k-1)/2].dist > heap[k].dist) {
                    State temp = heap[k];
                    heap[k] = heap[(k-1)/2];
                    heap[(k-1)/2] = temp;
                    k = (k-1)/2;
                }
            }
        }
    }

    free(heap);
    return dist;
}

int** modifiedGraphEdges(int n, int** edges, int edgesSize, int* edgesColSize, int source, int destination, int target, int* returnSize, int** returnColumnSizes) {
    EdgeInfo** graph = malloc(n * sizeof(EdgeInfo*));
    int* graphSize = calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        graphSize[u]++;
        graphSize[v]++;
    }

    for (int i = 0; i < n; i++) {
        graph[i] = malloc(graphSize[i] * sizeof(EdgeInfo));
        graphSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1], w = edges[i][2];
        graph[u][graphSize[u]++] = (EdgeInfo){v, w, i};
        graph[v][graphSize[v]++] = (EdgeInfo){u, w, i};
    }

    long long* distToDest = dijkstra(n, graph, graphSize, destination);

    if (distToDest[source] < target) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        for (int i = 0; i < n; i++) free(graph[i]);
        free(graph); free(graphSize); free(distToDest);
        return NULL;
    }

    long long* distFromSource = malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) distFromSource[i] = LLONG_MAX;
    distFromSource[source] = 0;

    State* heap = malloc(n * sizeof(State));
    int heapSize = 0;

    heap[heapSize].node = source;
    heap[heapSize].dist = 0;
    heapSize++;

    int* parent = malloc(n * sizeof(int));
    int* parentEdge = malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = -1;
        parentEdge[i] = -1;
    }

    while (heapSize > 0) {
        State cur = heap[0];
        heap[0] = heap[--heapSize];

        int i = 0;
        while (1) {
            int left = 2 * i + 1;
            int right = 2 * i + 2;
            int smallest = i;

            if (left < heapSize && heap[left].dist < heap[smallest].dist) smallest = left;
            if (right < heapSize && heap[right].dist < heap[smallest].dist) smallest = right;

            if (smallest == i) break;

            State temp = heap[i];
            heap[i] = heap[smallest];
            heap[smallest] = temp;
            i = smallest;
        }

        if (cur.dist > distFromSource[cur.node]) continue;

        for (int j = 0; j < graphSize[cur.node]; j++) {
            EdgeInfo edge = graph[cur.node][j];
            long long newDist;
            if (edge.weight == -1) {
                newDist = cur.dist + 1;
            } else {
                newDist = cur.dist + edge.weight;
            }

            if (newDist < distFromSource[edge.node]) {
                distFromSource[edge.node] = newDist;
                parent[edge.node] = cur.node;
                parentEdge[edge.node] = edge.idx;

                heap[heapSize].node = edge.node;
                heap[heapSize].dist = newDist;
                heapSize++;

                int k = heapSize - 1;
                while (k > 0 && heap[(k-1)/2].dist > heap[k].dist) {
                    State temp = heap[k];
                    heap[k] = heap[(k-1)/2];
                    heap[(k-1)/2] = temp;
                    k = (k-1)/2;
                }
            }
        }
    }

    if (distFromSource[destination] > target) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        for (int i = 0; i < n; i++) free(graph[i]);
        free(graph); free(graphSize); free(distToDest); free(distFromSource);
        free(heap); free(parent); free(parentEdge);
        return NULL;
    }

    int** result = malloc(edgesSize * sizeof(int*));
    *returnColumnSizes = malloc(edgesSize * sizeof(int));
    *returnSize = edgesSize;

    for (int i = 0; i < edgesSize; i++) {
        result[i] = malloc(3 * sizeof(int));
        result[i][0] = edges[i][0];
        result[i][1] = edges[i][1];
        result[i][2] = edges[i][2];
        (*returnColumnSizes)[i] = 3;
    }

    int node = destination;
    while (node != source) {
        int prev = parent[node];
        int edgeIdx = parentEdge[node];

        if (edges[edgeIdx][2] == -1) {
            long long need = target - distFromSource[node] - (node == destination ? 0 : distToDest[node]);
            if (need < 1) need = 1;
            result[edgeIdx][2] = need;

            for (int i = 0; i < n; i++) distFromSource[i] = LLONG_MAX;
            distFromSource[source] = 0;
            heapSize = 0;
            heap[heapSize].node = source;
            heap[heapSize].dist = 0;
            heapSize++;

            while (heapSize > 0) {
                State cur = heap[0];
                heap[0] = heap[--heapSize];

                int i = 0;
                while (1) {
                    int left = 2 * i + 1;
                    int right = 2 * i + 2;
                    int smallest = i;

                    if (left < heapSize && heap[left].dist < heap[smallest].dist) smallest = left;
                    if (right < heapSize && heap[right].dist < heap[smallest].