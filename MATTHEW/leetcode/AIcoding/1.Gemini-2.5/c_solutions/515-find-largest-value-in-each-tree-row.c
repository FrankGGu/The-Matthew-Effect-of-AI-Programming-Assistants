#include <stdlib.h> // For malloc, realloc, free
#include <limits.h> // For INT_MIN

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct QueueNode {
    struct TreeNode *treeNode;
    struct QueueNode *next;
};

struct Queue {
    struct QueueNode *front;
    struct QueueNode *rear;
    int size; // To keep track of the number of elements in the queue
};

struct Queue* createQueue() {
    struct Queue* q = (struct Queue*)malloc(sizeof(struct Queue));
    if (q == NULL) return NULL; // Handle malloc failure
    q->front = NULL;
    q->rear = NULL;
    q->size = 0;
    return q;
}

void enqueue(struct Queue* q, struct TreeNode* treeNode) {
    if (q == NULL) return;
    struct QueueNode* newNode = (struct QueueNode*)malloc(sizeof(struct QueueNode));
    if (newNode == NULL) return; // Handle malloc failure
    newNode->treeNode = treeNode;
    newNode->next = NULL;

    if (q->rear == NULL) { // Queue is empty
        q->front = newNode;
        q->rear = newNode;
    } else {
        q->rear->next = newNode;
        q->rear = newNode;
    }
    q->size++;
}

struct TreeNode* dequeue(struct Queue* q) {
    if (q == NULL || q->front == NULL) {
        return NULL; // Queue is empty or invalid
    }
    struct QueueNode* temp = q->front;
    struct TreeNode* treeNode = temp->treeNode;
    q->front = q->front->next;

    if (q->front == NULL) { // If queue becomes empty after dequeue
        q->rear = NULL;
    }
    free(temp);
    q->size--;
    return treeNode;
}

int isQueueEmpty(struct Queue* q) {
    return q == NULL || q->front == NULL;
}

int getQueueSize(struct Queue* q) {
    return q == NULL ? 0 : q->size;
}

void freeQueue(struct Queue* q) {
    if (q == NULL) return;
    while (!isQueueEmpty(q)) {
        dequeue(q); // Dequeue to free individual QueueNodes
    }
    free(q); // Free the Queue structure itself
}

int* largestValues(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;
    if (root == NULL) {
        return NULL;
    }

    int* result = NULL;
    int capacity = 10; // Initial capacity for the result array
    int count = 0;     // Current number of elements in the result array

    result = (int*)malloc(sizeof(int) * capacity);
    if (result == NULL) {
        return NULL; // Handle malloc failure
    }

    struct Queue* q = createQueue();
    if (q == NULL) {
        free(result);
        return NULL; // Handle queue creation failure
    }

    enqueue(q, root);

    while (!isQueueEmpty(q)) {
        int level_size = getQueueSize(q);
        int max_val_current_level = INT_MIN;

        for (int i = 0; i < level_size; i++) {
            struct TreeNode* current_node = dequeue(q);

            if (current_node->val > max_val_current_level) {
                max_val_current_level = current_node->val;
            }

            if (current_node->left != NULL) {
                enqueue(q, current_node->left);
            }
            if (current_node->right != NULL) {
                enqueue(q, current_node->right);
            }
        }

        // Add max_val_current_level to the result array
        if (count == capacity) {
            capacity *= 2; // Double the capacity
            int* new_result = (int*)realloc(result, sizeof(int) * capacity);
            if (new_result == NULL) {
                // Handle realloc failure: free existing resources and return NULL
                free(result);
                freeQueue(q);
                return NULL;
            }
            result = new_result;
        }
        result[count++] = max_val_current_level;
    }

    freeQueue(q); // Free all queue-related memory
    *returnSize = count;
    return result;
}