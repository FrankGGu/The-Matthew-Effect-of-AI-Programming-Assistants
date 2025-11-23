/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int id;
    int timestamp;
} LogEntry;

typedef struct {
    LogEntry* data;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->data = (LogEntry*)malloc(capacity * sizeof(LogEntry));
    stack->top = -1;
    stack->capacity = capacity;
    return stack;
}

void push(Stack* stack, int id, int timestamp) {
    stack->data[++stack->top] = (LogEntry){id, timestamp};
}

LogEntry pop(Stack* stack) {
    return stack->data[stack->top--];
}

LogEntry peek(Stack* stack) {
    return stack->data[stack->top];
}

int isEmpty(Stack* stack) {
    return stack->top == -1;
}

void freeStack(Stack* stack) {
    free(stack->data);
    free(stack);
}

int* exclusiveTime(int n, char** logs, int logsSize, int* returnSize) {
    int* result = (int*)calloc(n, sizeof(int));
    *returnSize = n;

    Stack* stack = createStack(logsSize);

    for (int i = 0; i < logsSize; i++) {
        char* log = logs[i];
        char* token = strtok(log, ":");
        int id = atoi(token);

        token = strtok(NULL, ":");
        char* type = token;

        token = strtok(NULL, ":");
        int timestamp = atoi(token);

        if (strcmp(type, "start") == 0) {
            if (!isEmpty(stack)) {
                LogEntry prev = peek(stack);
                result[prev.id] += timestamp - prev.timestamp;
            }
            push(stack, id, timestamp);
        } else {
            LogEntry curr = pop(stack);
            result[curr.id] += timestamp - curr.timestamp + 1;
            if (!isEmpty(stack)) {
                LogEntry prev = peek(stack);
                stack->data[stack->top].timestamp = timestamp + 1;
            }
        }
    }

    freeStack(stack);
    return result;
}