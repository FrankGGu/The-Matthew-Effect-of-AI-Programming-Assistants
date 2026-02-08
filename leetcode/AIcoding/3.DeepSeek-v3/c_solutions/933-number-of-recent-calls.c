typedef struct {
    int* requests;
    int front;
    int rear;
    int size;
} RecentCounter;

RecentCounter* recentCounterCreate() {
    RecentCounter* obj = (RecentCounter*)malloc(sizeof(RecentCounter));
    obj->size = 10000;
    obj->requests = (int*)malloc(obj->size * sizeof(int));
    obj->front = 0;
    obj->rear = 0;
    return obj;
}

int recentCounterPing(RecentCounter* obj, int t) {
    obj->requests[obj->rear++] = t;
    while (obj->requests[obj->front] < t - 3000) {
        obj->front++;
    }
    return obj->rear - obj->front;
}

void recentCounterFree(RecentCounter* obj) {
    free(obj->requests);
    free(obj);
}