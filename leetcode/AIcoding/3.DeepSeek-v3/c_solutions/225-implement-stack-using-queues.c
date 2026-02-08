typedef struct {
    int *data;
    int front;
    int rear;
    int size;
} Queue;

Queue* queueCreate(int size) {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->data = (int*)malloc(size * sizeof(int));
    q->front = 0;
    q->rear = 0;
    q->size = size;
    return q;
}

void queuePush(Queue *q, int x) {
    q->data[q->rear++] = x;
}

int queuePop(Queue *q) {
    return q->data[q->front++];
}

int queuePeek(Queue *q) {
    return q->data[q->front];
}

int queueEmpty(Queue *q) {
    return q->front == q->rear;
}

void queueFree(Queue *q) {
    free(q->data);
    free(q);
}

typedef struct {
    Queue *q1;
    Queue *q2;
} MyStack;

MyStack* myStackCreate() {
    MyStack *stack = (MyStack*)malloc(sizeof(MyStack));
    stack->q1 = queueCreate(100);
    stack->q2 = queueCreate(100);
    return stack;
}

void myStackPush(MyStack* obj, int x) {
    queuePush(obj->q1, x);
}

int myStackPop(MyStack* obj) {
    while (obj->q1->front != obj->q1->rear - 1) {
        queuePush(obj->q2, queuePop(obj->q1));
    }
    int val = queuePop(obj->q1);
    Queue *temp = obj->q1;
    obj->q1 = obj->q2;
    obj->q2 = temp;
    return val;
}

int myStackTop(MyStack* obj) {
    while (obj->q1->front != obj->q1->rear - 1) {
        queuePush(obj->q2, queuePop(obj->q1));
    }
    int val = queuePop(obj->q1);
    queuePush(obj->q2, val);
    Queue *temp = obj->q1;
    obj->q1 = obj->q2;
    obj->q2 = temp;
    return val;
}

int myStackEmpty(MyStack* obj) {
    return queueEmpty(obj->q1);
}

void myStackFree(MyStack* obj) {
    queueFree(obj->q1);
    queueFree(obj->q2);
    free(obj);
}