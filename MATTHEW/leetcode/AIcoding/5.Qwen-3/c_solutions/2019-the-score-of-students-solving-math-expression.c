#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct {
    int val;
    int idx;
} StackItem;

typedef struct {
    StackItem *data;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack *s = (Stack*)malloc(sizeof(Stack));
    s->data = (StackItem*)malloc(capacity * sizeof(StackItem));
    s->top = -1;
    s->capacity = capacity;
    return s;
}

void push(Stack *s, int val, int idx) {
    if (s->top + 1 >= s->capacity) {
        s->capacity *= 2;
        s->data = (StackItem*)realloc(s->data, s->capacity * sizeof(StackItem));
    }
    s->top++;
    s->data[s->top].val = val;
    s->data[s->top].idx = idx;
}

int pop(Stack *s) {
    if (s->top == -1) return -1;
    return s->data[s->top--].val;
}

int peek(Stack *s) {
    if (s->top == -1) return -1;
    return s->data[s->top].val;
}

void freeStack(Stack *s) {
    free(s->data);
    free(s);
}

int calculate(char *expression) {
    int len = strlen(expression);
    Stack *nums = createStack(10);
    Stack *ops = createStack(10);
    for (int i = 0; i < len; i++) {
        if (isdigit(expression[i])) {
            int num = 0;
            while (i < len && isdigit(expression[i])) {
                num = num * 10 + (expression[i] - '0');
                i++;
            }
            i--;
            push(nums, num, 0);
        } else if (expression[i] == '(') {
            push(ops, expression[i], 0);
        } else if (expression[i] == ')') {
            while (peek(ops) != '(') {
                int b = pop(nums);
                int a = pop(nums);
                char op = (char)pop(ops);
                int res = 0;
                if (op == '+') res = a + b;
                else if (op == '-') res = a - b;
                else if (op == '*') res = a * b;
                push(nums, res, 0);
            }
            pop(ops); // Remove '('
        } else {
            while (peek(ops) != -1 && peek(ops) != '(' && ((expression[i] == '*' && peek(ops) != '+') || expression[i] == '+')) {
                int b = pop(nums);
                int a = pop(nums);
                char op = (char)pop(ops);
                int res = 0;
                if (op == '+') res = a + b;
                else if (op == '-') res = a - b;
                else if (op == '*') res = a * b;
                push(nums, res, 0);
            }
            push(ops, expression[i], 0);
        }
    }
    while (peek(ops) != -1) {
        int b = pop(nums);
        int a = pop(nums);
        char op = (char)pop(ops);
        int res = 0;
        if (op == '+') res = a + b;
        else if (op == '-') res = a - b;
        else if (op == '*') res = a * b;
        push(nums, res, 0);
    }
    int result = pop(nums);
    freeStack(nums);
    freeStack(ops);
    return result;
}

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int scoreOfStudents(char ** students, int studentsSize) {
    int correct = calculate("3+2*2");
    int total = 0;
    int *scores = (int*)malloc(studentsSize * sizeof(int));
    for (int i = 0; i < studentsSize; i++) {
        int s = calculate(students[i]);
        if (s == correct) {
            total += 1;
        }
    }
    free(scores);
    return total;
}