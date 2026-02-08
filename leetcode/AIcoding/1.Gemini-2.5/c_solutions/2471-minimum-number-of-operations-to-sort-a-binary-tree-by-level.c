#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For memset (optional, calloc does it)

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode** nodes;
    int front;
    int rear;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1; // rear points to the last element added
    q->nodes = (struct TreeNode**)malloc(q->capacity * sizeof(struct TreeNode*));
    return q;
}

void enqueue(Queue* q, struct TreeNode* node) {
    // Assuming capacity is sufficient for problem constraints (max 2000 nodes)
    // If not, realloc would be needed, but not typical for LeetCode fixed-size queue patterns.
    q->nodes[++(q->rear)] = node;
}

struct TreeNode* dequeue(Queue* q) {
    if (q->front > q->rear) { // Queue is empty
        return NULL;
    }
    return q->nodes[(q->front)++];
}

int isQueueEmpty(Queue* q) {
    return q->front > q->rear;
}

int queueSize(Queue* q) {
    return q->rear - q->front + 1;
}

void freeQueue(Queue* q) {
    free(q->nodes);
    free(q);
}

typedef struct {
    int val;
    int original_idx;
} Pair;

int comparePairs(const void* a, const void* b) {
    return ((Pair*)a)->val - ((Pair*)b)->val;
}

int minSwaps(int* arr, int n) {
    if (n <= 1) {
        return 0;
    }

    Pair* pairs = (Pair*)malloc(n * sizeof(Pair));
    for (int i = 0; i < n; i++) {
        pairs[i].val = arr[i];
        pairs[i].original_idx = i;
    }

    // Sort pairs based on value.
    // After sorting, pairs[i].val is the i-th smallest value,
    // and pairs[i].original_idx is its original index in `arr`.
    qsort(pairs, n, sizeof(Pair), comparePairs);

    int swaps = 0;
    // visited array to keep track of elements already part of a cycle
    // calloc initializes memory to zero.
    int* visited = (int*)calloc(n, sizeof(int)); 

    for (int i = 0; i < n; i++) {
        // If element is already visited or is in its correct sorted position
        // pairs[i].original_idx == i means the element that should be at index i
        // was already at index i in the original array.
        if (visited[i] || pairs[i].original_idx == i) {
            continue;
        }

        // Start a new cycle
        int cycle_size = 0;
        int current_node_idx = i; // Start from the current position in the sorted array

        // Traverse the cycle
        while (!visited[current_node_idx]) {
            visited[current_node_idx] = 1; // Mark as visited
            // Move to the original index of the value that *should* be at current_node_idx
            current_node_idx = pairs[current_node_idx].original_idx;
            cycle_size++;
        }

        // A cycle of length 'k' requires 'k-1' swaps
        if (cycle_size > 0) {
            swaps += (cycle_size - 1);
        }
    }

    free(pairs);
    free(visited);
    return swaps;
}

int minimumOperations(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }

    int total_swaps = 0;
    // Max nodes 2000, so a queue capacity of 2005 is safe to avoid realloc.
    Queue* q = createQueue(2005); 
    enqueue(q, root);

    while (!isQueueEmpty(q)) {
        int level_size = queueSize(q);
        // Allocate memory for current level's values
        int* level_values = (int*)malloc(level_size * sizeof(int));

        for (int i = 0; i < level_size; i++) {
            struct TreeNode* current = dequeue(q);
            level_values[i] = current->val;

            if (current->left) {
                enqueue(q, current->left);
            }
            if (current->right) {
                enqueue(q, current->right);
            }
        }

        total_swaps += minSwaps(level_values, level_size);
        free(level_values); // Free memory for level values
    }

    freeQueue(q); // Free queue resources
    return total_swaps;
}