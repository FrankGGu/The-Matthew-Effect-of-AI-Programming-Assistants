typedef struct {
    int* data;
    int front;
    int rear;
    int size;
} MyQueue;

MyQueue* myQueueCreate() {
    MyQueue* obj = (MyQueue*)malloc(sizeof(MyQueue));
    obj->data = (int*)malloc(1000 * sizeof(int));
    obj->front = 0;
    obj->rear = 0;
    obj->size = 0;
    return obj;
}

void myQueuePush(MyQueue* obj, int x) {
    obj->data[obj->rear] = x;
    obj->rear = (obj->rear + 1) % 1000;
    obj->size++;
}

int myQueuePop(MyQueue* obj) {
    int val = obj->data[obj->front];
    obj->front = (obj->front + 1) % 1000;
    obj->size--;
    return val;
}

int myQueuePeek(MyQueue* obj) {
    return obj->data[obj->front];
}

int myQueueEmpty(MyQueue* obj) {
    return obj->size == 0;
}

void myQueueFree(MyQueue* obj) {
    free(obj->data);
    free(obj);
}

typedef struct {
    MyQueue* q1;
    MyQueue* q2;
} CQueue;

CQueue* cQueueCreate() {
    CQueue* obj = (CQueue*)malloc(sizeof(CQueue));
    obj->q1 = myQueueCreate();
    obj->q2 = myQueueCreate();
    return obj;
}

void cQueueAppendTail(CQueue* obj, int value) {
    myQueuePush(obj->q1, value);
}

int cQueueDeleteHead(CQueue* obj) {
    if (myQueueEmpty(obj->q2)) {
        while (!myQueueEmpty(obj->q1)) {
            myQueuePush(obj->q2, myQueuePop(obj->q1));
        }
    }
    if (myQueueEmpty(obj->q2)) {
        return -1;
    }
    return myQueuePop(obj->q2);
}

void cQueueFree(CQueue* obj) {
    myQueueFree(obj->q1);
    myQueueFree(obj->q2);
    free(obj);
}