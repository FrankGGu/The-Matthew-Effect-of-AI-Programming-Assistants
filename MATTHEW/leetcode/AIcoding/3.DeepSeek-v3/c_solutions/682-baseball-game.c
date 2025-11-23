typedef struct {
    int *data;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack *stack = (Stack*)malloc(sizeof(Stack));
    stack->data = (int*)malloc(sizeof(int) * capacity);
    stack->top = -1;
    stack->capacity = capacity;
    return stack;
}

void push(Stack *stack, int value) {
    if (stack->top == stack->capacity - 1) {
        stack->capacity *= 2;
        stack->data = (int*)realloc(stack->data, sizeof(int) * stack->capacity);
    }
    stack->data[++stack->top] = value;
}

int pop(Stack *stack) {
    return stack->data[stack->top--];
}

int peek(Stack *stack) {
    return stack->data[stack->top];
}

int isEmpty(Stack *stack) {
    return stack->top == -1;
}

void freeStack(Stack *stack) {
    free(stack->data);
    free(stack);
}

int calPoints(char** operations, int operationsSize) {
    Stack *stack = createStack(operationsSize);

    for (int i = 0; i < operationsSize; i++) {
        if (strcmp(operations[i], "+") == 0) {
            int top = pop(stack);
            int newTop = top + peek(stack);
            push(stack, top);
            push(stack, newTop);
        } else if (strcmp(operations[i], "D") == 0) {
            push(stack, 2 * peek(stack));
        } else if (strcmp(operations[i], "C") == 0) {
            pop(stack);
        } else {
            push(stack, atoi(operations[i]));
        }
    }

    int sum = 0;
    while (!isEmpty(stack)) {
        sum += pop(stack);
    }

    freeStack(stack);
    return sum;
}