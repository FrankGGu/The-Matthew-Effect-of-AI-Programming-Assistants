#include <stdlib.h>
#include <limits.h>

static inline int min(int a, int b) {
    return a < b ? a : b;
}

int mctFromLeafValues(int* arr, int arrSize) {
    int* stack = (int*) malloc((arrSize + 1) * sizeof(int));
    int stack_top_idx = -1;

    stack_top_idx++;
    stack[stack_top_idx] = INT_MAX;

    int total_cost = 0;

    for (int i = 0; i < arrSize; i++) {
        int current_val = arr[i];
        while (stack[stack_top_idx] <= current_val) {
            int mid_val = stack[stack_top_idx];
            stack_top_idx--;
            total_cost += mid_val * min(stack[stack_top_idx], current_val);
        }
        stack_top_idx++;
        stack[stack_top_idx] = current_val;
    }

    while (stack_top_idx > 1) {
        int mid_val = stack[stack_top_idx];
        stack_top_idx--;
        total_cost += mid_val * stack[stack_top_idx];
    }

    free(stack);
    return total_cost;
}