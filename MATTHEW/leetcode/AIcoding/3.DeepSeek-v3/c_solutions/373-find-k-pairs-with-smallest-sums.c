/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
typedef struct {
    int sum;
    int i;
    int j;
} Pair;

void swap(Pair* a, Pair* b) {
    Pair temp = *a;
    *a = *b;
    *b = temp;
}

void heapify(Pair* heap, int size, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < size && heap[left].sum < heap[smallest].sum) {
        smallest = left;
    }

    if (right < size && heap[right].sum < heap[smallest].sum) {
        smallest = right;
    }

    if (smallest != i) {
        swap(&heap[i], &heap[smallest]);
        heapify(heap, size, smallest);
    }
}

void push(Pair* heap, int* size, int sum, int i, int j) {
    heap[*size].sum = sum;
    heap[*size].i = i;
    heap[*size].j = j;
    (*size)++;

    for (int idx = (*size) / 2 - 1; idx >= 0; idx--) {
        heapify(heap, *size, idx);
    }
}

Pair pop(Pair* heap, int* size) {
    Pair top = heap[0];
    heap[0] = heap[(*size) - 1];
    (*size)--;
    heapify(heap, *size, 0);
    return top;
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize, int** returnColumnSizes) {
    if (nums1Size == 0 || nums2Size == 0 || k == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int heapSize = 0;
    int heapCapacity = nums1Size * nums2Size;
    Pair* heap = (Pair*)malloc(heapCapacity * sizeof(Pair));

    for (int i = 0; i < nums1Size; i++) {
        push(heap, &heapSize, nums1[i] + nums2[0], i, 0);
    }

    int** result = (int**)malloc(k * sizeof(int*));
    *returnColumnSizes = (int*)malloc(k * sizeof(int));
    *returnSize = 0;

    while (k > 0 && heapSize > 0) {
        Pair current = pop(heap, &heapSize);
        int i = current.i;
        int j = current.j;

        result[*returnSize] = (int*)malloc(2 * sizeof(int));
        result[*returnSize][0] = nums1[i];
        result[*returnSize][1] = nums2[j];
        (*returnColumnSizes)[*returnSize] = 2;
        (*returnSize)++;
        k--;

        if (j + 1 < nums2Size) {
            push(heap, &heapSize, nums1[i] + nums2[j + 1], i, j + 1);
        }
    }

    free(heap);
    return result;
}