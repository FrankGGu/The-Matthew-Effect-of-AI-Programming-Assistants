typedef struct {
    struct queue *q1;
    struct queue *q2;
} MyStack;

MyStack* myStackCreate() {
    MyStack *stack = (MyStack *)malloc(sizeof(MyStack));
    stack->q1 = queueCreate();
    stack->q2 = queueCreate();
    return stack;
}

void myStackPush(MyStack* obj, int x) {
    queueEnqueue(obj->q2, x);
    while (!queueIsEmpty(obj->q1)) {
        queueEnqueue(obj->q2, queueDequeue(obj->q1));
    }
    struct queue *temp = obj->q1;
    obj->q1 = obj->q2;
    obj->q2 = temp;
}

int myStackPop(MyStack* obj) {
    return queueDequeue(obj->q1);
}

int myStackTop(MyStack* obj) {
    return obj->q1->front->val;
}

bool myStackEmpty(MyStack* obj) {
    return queueIsEmpty(obj->q1);
}

void myStackFree(MyStack* obj) {
    queueFree(obj->q1);
    queueFree(obj->q2);
    free(obj);
}