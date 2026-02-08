#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int index;
} Pair;

int cmp(const void* a, const void* b) {
    Pair* pa = (Pair*)a;
    Pair* pb = (Pair*)b;
    if (pa->val == pb->val) {
        return pa->index - pb->index;
    }
    return pa->val - pb->val;
}

int oddEvenJumps(int* arr, int arrSize) {
    if (arrSize == 1) return 1;

    int* nextHigher = (int*)malloc(arrSize * sizeof(int));
    int* nextLower = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        nextHigher[i] = -1;
        nextLower[i] = -1;
    }

    Pair* pairs = (Pair*)malloc(arrSize * sizeof(Pair));
    for (int i = 0; i < arrSize; i++) {
        pairs[i].val = arr[i];
        pairs[i].index = i;
    }

    qsort(pairs, arrSize, sizeof(Pair), cmp);

    int* stack = (int*)malloc(arrSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < arrSize; i++) {
        while (top >= 0 && pairs[i].index > stack[top]) {
            nextHigher[stack[top]] = pairs[i].index;
            top--;
        }
        stack[++top] = pairs[i].index;
    }

    for (int i = 0; i < arrSize; i++) {
        pairs[i].val = -arr[i];
        pairs[i].index = i;
    }

    qsort(pairs, arrSize, sizeof(Pair), cmp);

    top = -1;
    for (int i = 0; i < arrSize; i++) {
        while (top >= 0 && pairs[i].index > stack[top]) {
            nextLower[stack[top]] = pairs[i].index;
            top--;
        }
        stack[++top] = pairs[i].index;
    }

    int* odd = (int*)malloc(arrSize * sizeof(int));
    int* even = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        odd[i] = 0;
        even[i] = 0;
    }
    odd[arrSize - 1] = 1;
    even[arrSize - 1] = 1;

    int res = 1;
    for (int i = arrSize - 2; i >= 0; i--) {
        if (nextHigher[i] != -1) {
            odd[i] = even[nextHigher[i]];
        }
        if (nextLower[i] != -1) {
            even[i] = odd[nextLower[i]];
        }
        if (odd[i]) {
            res++;
        }
    }

    free(nextHigher);
    free(nextLower);
    free(pairs);
    free(stack);
    free(odd);
    free(even);

    return res;
}