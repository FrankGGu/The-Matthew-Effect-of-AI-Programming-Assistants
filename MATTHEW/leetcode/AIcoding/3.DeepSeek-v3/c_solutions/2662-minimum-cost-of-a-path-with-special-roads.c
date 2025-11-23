typedef struct {
    int x;
    int y;
    int cost;
} Point;

typedef struct {
    Point* points;
    int size;
    int capacity;
} MinHeap;

MinHeap* createHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->points = (Point*)malloc(capacity * sizeof(Point));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(Point* a, Point* b) {
    Point temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (heap->points[parent].cost <= heap->points[idx].cost) break;
        swap(&heap->points[parent], &heap->points[idx]);
        idx = parent;
    }
}

void heapifyDown(MinHeap* heap, int idx) {
    int left, right, smallest;
    while (1) {
        left = 2 * idx + 1;
        right = 2 * idx + 2;
        smallest = idx;

        if (left < heap->size && heap->points[left].cost < heap->points[smallest].cost)
            smallest = left;
        if (right < heap->size && heap->points[right].cost < heap->points[smallest].cost)
            smallest = right;

        if (smallest == idx) break;
        swap(&heap->points[idx], &heap->points[smallest]);
        idx = smallest;
    }
}

void push(MinHeap* heap, Point point) {
    if (heap->size == heap->capacity) return;
    heap->points[heap->size] = point;
    heapifyUp(heap, heap->size);
    heap->size++;
}

Point pop(MinHeap* heap) {
    Point result = heap->points[0];
    heap->points[0] = heap->points[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return result;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int abs(int x) {
    return x < 0 ? -x : x;
}

int minimumCost(int* start, int startSize, int* target, int targetSize, int** specialRoads, int specialRoadsSize, int* specialRoadsColSize) {
    int INF = 1e9;
    int n = specialRoadsSize;

    int* dist = (int*)malloc((n + 2) * sizeof(int));
    for (int i = 0; i < n + 2; i++) {
        dist[i] = INF;
    }

    MinHeap* heap = createHeap(n * n);

    Point startPoint = {start[0], start[1], 0};
    push(heap, startPoint);

    while (heap->size > 0) {
        Point curr = pop(heap);
        int x = curr.x, y = curr.y, cost = curr.cost;

        if (x == target[0] && y == target[1]) {
            free(dist);
            free(heap->points);
            free(heap);
            return cost;
        }

        int directCost = cost + abs(x - target[0]) + abs(y - target[1]);
        if (directCost < dist[n]) {
            dist[n] = directCost;
            Point p = {target[0], target[1], directCost};
            push(heap, p);
        }

        for (int i = 0; i < n; i++) {
            int x1 = specialRoads[i][0];
            int y1 = specialRoads[i][1];
            int x2 = specialRoads[i][2];
            int y2 = specialRoads[i][3];
            int roadCost = specialRoads[i][4];

            int newCost = cost + abs(x - x1) + abs(y - y1) + roadCost;
            if (newCost < dist[i]) {
                dist[i] = newCost;
                Point p = {x2, y2, newCost};
                push(heap, p);
            }
        }
    }

    free(dist);
    free(heap->points);
    free(heap);
    return -1;
}