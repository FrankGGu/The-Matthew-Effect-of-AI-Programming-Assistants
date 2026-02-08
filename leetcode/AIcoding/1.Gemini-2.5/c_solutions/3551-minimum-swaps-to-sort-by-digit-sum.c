#include <stdlib.h> // For qsort, malloc, free
#include <stdbool.h> // For bool type, true, false

int digitSum(int n) {
    int sum = 0;
    if (n == 0) {
        return 0;
    }
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

typedef struct {
    int val;
    int sum;
    int original_idx;
} Element;

int compareElements(const void *a, const void *b) {
    Element *elemA = (Element *)a;
    Element *elemB = (Element *)b;

    if (elemA->sum != elemB->sum) {
        return elemA->sum - elemB->sum;
    }
    return elemA->val - elemB->val;
}

int minSwaps(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    Element* elements = (Element*)malloc(numsSize * sizeof(Element));

    for (int i = 0; i < numsSize; i++) {
        elements[i].val = nums[i];
        elements[i].sum = digitSum(nums[i]);
        elements[i].original_idx = i;
    }

    qsort(elements, numsSize, sizeof(Element), compareElements);

    int* target_indices = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        target_indices[elements[i].original_idx] = i;
    }

    bool* visited = (bool*)calloc(numsSize, sizeof(bool));

    int swaps = 0;
    for (int i = 0; i < numsSize; i++) {
        if (!visited[i]) {
            int cycle_size = 0;
            int current_original_idx = i;

            while (!visited[current_original_idx]) {
                visited[current_original_idx] = true;
                current_original_idx = target_indices[current_original_idx];
                cycle_size++;
            }

            if (cycle_size > 1) {
                swaps += (cycle_size - 1);
            }
        }
    }

    free(elements);
    free(target_indices);
    free(visited);

    return swaps;
}