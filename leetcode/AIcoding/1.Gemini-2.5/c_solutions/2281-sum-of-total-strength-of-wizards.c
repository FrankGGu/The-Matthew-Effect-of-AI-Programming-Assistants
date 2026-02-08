#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int* data;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->capacity = capacity;
    stack->top = -1;
    stack->data = (int*)malloc(sizeof(int) * capacity);
    return stack;
}

void push(Stack* stack, int item) {
    stack->data[++stack->top] = item;
}

int pop(Stack* stack) {
    return stack->data[stack->top--];
}

int peek(Stack* stack) {
    return stack->data[stack->top];
}

int isEmpty(Stack* stack) {
    return stack->top == -1;
}

void freeStack(Stack* stack) {
    free(stack->data);
    free(stack);
}

int sumOfTotalStrength(int* strength, int strengthSize) {
    long long MOD = 1000000007;

    // Calculate P (prefix sums) and SP (prefix sums of i*strength[i])
    // P[k] = sum_{j=0}^{k-1} strength[j]
    // SP[k] = sum_{j=0}^{k-1} j * strength[j]
    long long* P = (long long*)calloc(strengthSize + 1, sizeof(long long));
    long long* SP = (long long*)calloc(strengthSize + 1, sizeof(long long));

    for (int i = 0; i < strengthSize; ++i) {
        P[i+1] = (P[i] + strength[i]) % MOD;
        SP[i+1] = (SP[i] + (1LL * i * strength[i]) % MOD) % MOD;
    }

    // Calculate PP (prefix sums of P)
    // PP[k] = sum_{j=0}^{k-1} P[j]
    // Using formula: PP[k] = (k-1) * P[k-1] - SP[k-1]
    long long* PP = (long long*)calloc(strengthSize + 2, sizeof(long long));
    PP[0] = 0;
    PP[1] = 0; // P[0] = 0
    for (int k = 2; k <= strengthSize + 1; ++k) {
        long long term1 = (1LL * (k - 1) * P[k - 1]) % MOD;
        long long term2 = SP[k - 1];
        PP[k] = (term1 - term2 + MOD) % MOD;
    }

    // Calculate L (previous strictly smaller element index)
    // L[i]: largest index p < i such that strength[p] < strength[i]. If none, L[i] = -1.
    int* L = (int*)malloc(sizeof(int) * strengthSize);
    Stack* stack = createStack(strengthSize);
    for (int i = 0; i < strengthSize; ++i) {
        while (!isEmpty(stack) && strength[peek(stack)] >= strength[i]) {
            pop(stack);
        }
        L[i] = isEmpty(stack) ? -1 : peek(stack);
        push(stack, i);
    }
    freeStack(stack);

    // Calculate R (next smaller or equal element index)
    // R[i]: smallest index q > i such that strength[q] <= strength[i]. If none, R[i] = strengthSize.
    int* R = (int*)malloc(sizeof(int) * strengthSize);
    stack = createStack(strengthSize);
    for (int i = strengthSize - 1; i >= 0; --i) {
        while (!isEmpty(stack) && strength[peek(stack)] > strength[i]) {
            pop(stack);
        }
        R[i] = isEmpty(stack) ? strengthSize : peek(stack);
        push(stack, i);
    }
    freeStack(stack);

    long long totalStrength = 0;

    for (int i = 0; i < strengthSize; ++i) {
        long long l = L[i];
        long long r = R[i];

        long long left_count = i - l; // Number of elements from L[i]+1 to i (inclusive)
        long long right_count = r - i; // Number of elements from i to R[i]-1 (inclusive)

        // Calculate sum_{k=i}^{R[i]-1} P[k+1]
        // This is sum_{idx=i+1}^{R[i]} P[idx]
        // Using PP: (PP[R[i]+1] - PP[i+1] + MOD) % MOD
        long long sum_P_k_plus_1 = (PP[r + 1] - PP[i + 1] + MOD) % MOD;

        // Calculate sum_{j=L[i]+1}^{i} P[j]
        // This is sum_{idx=L[i]+1}^{i} P[idx]
        // Using PP: (PP[i+1] - PP[L[i]+1] + MOD) % MOD
        long long sum_P_j = (PP[i + 1] - PP[l + 1] + MOD) % MOD;

        // term = (left_count * sum_P_k_plus_1 - right_count * sum_P_j)
        long long term_part1 = (left_count % MOD * sum_P_k_plus_1) % MOD;
        long long term_part2 = (right_count % MOD * sum_P_j) % MOD;

        long long term = (term_part1 - term_part2 + MOD) % MOD;

        long long contribution = (1LL * strength[i] * term) % MOD;
        totalStrength = (totalStrength + contribution) % MOD;
    }

    free(P);
    free(SP);
    free(PP);
    free(L);
    free(R);

    return (int)totalStrength;
}