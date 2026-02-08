#define MAX 10000
#define INF 0x3f3f3f3f

typedef struct {
    int busStop;
    int busCount;
} State;

int numBusesToDestination(int** routes, int routesSize, int* routesColSize, int S, int T) {
    if (S == T) return 0;

    int graph[MAX] = {0};
    for (int i = 0; i < routesSize; i++) {
        for (int j = 0; j < routesColSize[i]; j++) {
            graph[routes[i][j]] |= (1 << i);
        }
    }

    int queue[MAX];
    int front = 0, rear = 0;
    int visitedBus[MAX] = {0};
    int visitedStop[MAX] = {0};

    queue[rear++] = S;
    visitedStop[S] = 1;

    int busCount = 0;

    while (front < rear) {
        int size = rear - front;
        busCount++;

        for (int i = 0; i < size; i++) {
            int stop = queue[front++];

            for (int j = 0; j < routesSize; j++) {
                if (graph[stop] & (1 << j) && !visitedBus[j]) {
                    visitedBus[j] = 1;

                    for (int k = 0; k < routesColSize[j]; k++) {
                        int nextStop = routes[j][k];
                        if (nextStop == T) return busCount;
                        if (!visitedStop[nextStop]) {
                            visitedStop[nextStop] = 1;
                            queue[rear++] = nextStop;
                        }
                    }
                }
            }
        }
    }

    return -1;
}