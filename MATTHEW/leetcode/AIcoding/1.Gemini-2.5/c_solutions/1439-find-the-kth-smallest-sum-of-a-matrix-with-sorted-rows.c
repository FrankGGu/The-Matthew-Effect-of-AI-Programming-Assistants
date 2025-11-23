#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset
#include <math.h>   // For fmin

#define MAX_HEAP_CAPACITY 250 

typedef struct {
    int sum;
    int idxA; // index in listA
    int idxB; // index in listB
} HeapElem;

HeapElem heap[MAX_HEAP_CAPACITY];
int heap_size;

void swap(HeapElem* a, HeapElem* b) {
    HeapElem temp = *a;
    *a = *b;
    *b = temp;
}

void heap_push(HeapElem item) {
    if (heap_size >= MAX_HEAP_CAPACITY) {
        return; 
    }
    heap[heap_size] = item;
    int current = heap_size;
    while (current > 0 && heap[current].sum < heap[(current - 1) / 2].sum) {
        swap(&heap[current], &heap[(current - 1) / 2]);
        current = (current - 1) / 2;
    }
    heap_size++;
}

HeapElem heap_pop() {
    HeapElem root = heap[0];
    heap_size--;
    if (heap_size > 0) {
        heap[0] = heap[heap_size];
        int current = 0;
        while (true) {
            int left_child = 2 * current + 1;
            int right_child = 2 * current + 2;
            int smallest = current;

            if (left_child < heap_size && heap[left_child].sum < heap[smallest].sum) {
                smallest = left_child;
            }
            if (right_child < heap_size && heap[right_child].sum < heap[smallest].sum) {
                smallest = right_child;
            }

            if (smallest != current) {
                swap(&heap[current], &heap[smallest]);
                current = smallest;
            } else {
                break;
            }
        }
    }
    return root;
}

void heap_init() {
    heap_size = 0;
}

int* mergeTwoLists(int* listA, int sizeA, int* listB, int sizeB, int k, int* returnSize) {
    heap_init();

    static bool visited[201][41]; 
    memset(visited, 0, sizeof(visited));

    int* result = (int*)malloc(sizeof(int) * k);
    *returnSize = 0;

    if (sizeA == 0 || sizeB == 0) {
        return result;
    }

    HeapElem initial = {listA[0] + listB[0], 0, 0};
    heap_push(initial);
    visited[0][0] = true;

    while (heap_size > 0 && *returnSize < k) {
        HeapElem current = heap_pop();
        result[*returnSize] = current.sum;
        (*returnSize)++;

        if (current.idxA + 1 < sizeA && !visited[current.idxA + 1][current.idxB]) {
            HeapElem nextA = {listA[current.idxA + 1] + listB[current.idxB], current.idxA + 1, current.idxB};
            heap_push(nextA);
            visited[current.idxA + 1][current.idxB] = true;
        }

        if (current.idxB + 1 < sizeB && !visited[current.idxA][current.idxB + 1]) {
            HeapElem nextB = {listA[current.idxA] + listB[current.idxB + 1], current.idxA, current.idxB + 1};
            heap_push(nextB);
            visited[current.idxA][current.idxB + 1] = true;
        }
    }
    return result;
}

int kthSmallestSum(int** mat, int matSize, int* matColSize, int k) {
    int n = matColSize[0]; 

    int initial_list_size = fmin(n, k);
    int* current_sums = (int*)malloc(sizeof(int) * initial_list_size);
    for (int i = 0; i < initial_list_size; ++i) {
        current_sums[i] = mat[0][i];
    }
    int current_sums_size = initial_list_size;

    for (int r = 1; r < matSize; ++r) {
        int* new_sums;
        int new_sums_size;
        new_sums = mergeTwoLists(current_sums, current_sums_size, mat[r], n, k, &new_sums_size);
        free(current_sums);
        current_sums = new_sums;
        current_sums_size = new_sums_size;
    }

    int result = current_sums[k - 1];
    free(current_sums);
    return result;
}