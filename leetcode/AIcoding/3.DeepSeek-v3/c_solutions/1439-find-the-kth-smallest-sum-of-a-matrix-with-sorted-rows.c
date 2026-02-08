/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int sum;
    int* indices;
} Node;

void swap(Node* a, Node* b) {
    Node temp = *a;
    *a = *b;
    *b = temp;
}

void heapify(Node* heap, int size, int i) {
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

void push(Node* heap, int* size, Node node) {
    heap[*size] = node;
    int i = *size;
    (*size)++;

    while (i > 0 && heap[(i - 1) / 2].sum > heap[i].sum) {
        swap(&heap[(i - 1) / 2], &heap[i]);
        i = (i - 1) / 2;
    }
}

Node pop(Node* heap, int* size) {
    Node root = heap[0];
    heap[0] = heap[(*size) - 1];
    (*size)--;
    heapify(heap, *size, 0);
    return root;
}

int kthSmallest(int** mat, int matSize, int* matColSize, int k) {
    int n = matSize;
    int m = matColSize[0];

    int* indices = (int*)calloc(n, sizeof(int));
    int initialSum = 0;
    for (int i = 0; i < n; i++) {
        initialSum += mat[i][0];
    }

    Node* heap = (Node*)malloc(100000 * sizeof(Node));
    int heapSize = 0;

    Node start;
    start.sum = initialSum;
    start.indices = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        start.indices[i] = 0;
    }
    push(heap, &heapSize, start);

    int visited[50000] = {0};

    while (k > 1) {
        Node current = pop(heap, &heapSize);

        for (int i = 0; i < n; i++) {
            if (current.indices[i] + 1 < m) {
                int* newIndices = (int*)malloc(n * sizeof(int));
                for (int j = 0; j < n; j++) {
                    newIndices[j] = current.indices[j];
                }
                newIndices[i]++;

                int hash = 0;
                for (int j = 0; j < n; j++) {
                    hash = hash * (m + 1) + newIndices[j];
                }

                if (!visited[hash]) {
                    visited[hash] = 1;

                    int newSum = current.sum - mat[i][current.indices[i]] + mat[i][newIndices[i]];

                    Node newNode;
                    newNode.sum = newSum;
                    newNode.indices = newIndices;
                    push(heap, &heapSize, newNode);
                } else {
                    free(newIndices);
                }
            }
        }
        free(current.indices);
        k--;
    }

    int result = heap[0].sum;

    for (int i = 0; i < heapSize; i++) {
        free(heap[i].indices);
    }
    free(heap);
    free(indices);

    return result;
}