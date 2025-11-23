typedef struct {
    int* requests;
    int front;
    int rear;
    int size;
} RecentCounter;

RecentCounter* recentCounterCreate() {
    RecentCounter* obj = (RecentCounter*)malloc(sizeof(RecentCounter));
    obj->requests = (int*)malloc(10000 * sizeof(int));
    obj->front = 0;
    obj->rear = 0;
    obj->size = 10000;
    return obj;
}

int recentCounterPing(RecentCounter* obj, int t) {
    obj->requests[obj->rear] = t;
    obj->rear = (obj->rear + 1) % obj->size;

    while (obj->requests[obj->front] < t - 3000) {
        obj->front = (obj->front + 1) % obj->size;
    }

    return (obj->rear - obj->front + obj->size) % obj->size;
}

void recentCounterFree(RecentCounter* obj) {
    free(obj->requests);
    free(obj);
}