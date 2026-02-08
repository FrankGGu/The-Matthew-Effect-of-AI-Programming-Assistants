#include <stdlib.h> // Required for malloc, realloc, free

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode** data;
    int front;
    int rear;
    int capacity;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->data = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * capacity);
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, struct TreeNode* node) {
    // This implementation assumes the initial capacity is sufficient
    // for the problem constraints (max 10^4 nodes).
    // For a general-purpose queue, dynamic resizing with realloc 
    // and handling of circular buffer elements would be needed here.
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = node;
    q->size++;
}

struct TreeNode* dequeue(Queue* q) {
    if (q->size == 0) {
        return NULL; // Queue is empty
    }
    struct TreeNode* node = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return node;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

int queueSize(Queue* q) {
    return q->size;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

double* averageOfLevels(struct TreeNode* root, int* returnSize) {
    *returnSize = 0; // Initialize returnSize to 0

    if (root == NULL) {
        return NULL; // No nodes, return NULL as per common LeetCode practice for empty results
    }

    // Initialize the queue. Max nodes in the tree is 10^4, so capacity 10000 is sufficient.
    Queue* q = createQueue(10000); 
    enqueue(q, root);

    // Initialize dynamic array for storing results
    double* result = NULL;
    int result_capacity = 10; // Initial capacity for the result array
    result = (double*)malloc(sizeof(double) * result_capacity);
    if (result == NULL) {
        freeQueue(q);
        return NULL; // Handle malloc failure
    }

    while (!isEmpty(q)) {
        int level_size = queueSize(q);
        double level_sum = 0.0;
        int level_count = 0;

        // Process all nodes at the current level
        for (int i = 0; i < level_size; i++) {
            struct TreeNode* current_node = dequeue(q);
            level_sum += current_node->val;
            level_count++;

            // Enqueue children for the next level
            if (current_node->left != NULL) {
                enqueue(q, current_node->left);
            }
            if (current_node->right != NULL) {
                enqueue(q, current_node->right);
            }
        }

        // Calculate average for the current level and add to result array
        if (*returnSize == result_capacity) {
            result_capacity *= 2; // Double capacity if needed
            double* new_result = (double*)realloc(result, sizeof(double) * result_capacity);
            if (new_result == NULL) {
                // Handle realloc failure
                free(result);
                freeQueue(q);
                return NULL;
            }
            result = new_result;
        }
        result[*returnSize] = level_sum / level_count;
        (*returnSize)++;
    }

    freeQueue(q); // Free the memory allocated for the queue
    return result;
}