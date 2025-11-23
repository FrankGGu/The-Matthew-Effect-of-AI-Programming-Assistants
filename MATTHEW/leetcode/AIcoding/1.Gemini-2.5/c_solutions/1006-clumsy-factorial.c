long long stack[10000];
int stack_top;

void push(long long val) {
    stack[++stack_top] = val;
}

long long pop() {
    return stack[stack_top--];
}

int clumsy(int n) {
    stack_top = -1;

    push(n);

    for (int i = n - 1; i >= 1; --i) {
        int op_type = (n - 1 - i) % 4;

        if (op_type == 0) { // Multiplication
            long long prev = pop();
            push(prev * i);
        } else if (op_type == 1) { // Division
            long long prev = pop();
            push(prev / i);
        } else if (op_type == 2) { // Addition
            push(i);
        } else { // Subtraction
            push(-i);
        }
    }

    long long final_sum = 0;
    while (stack_top != -1) {
        final_sum += pop();
    }

    return (int)final_sum;
}