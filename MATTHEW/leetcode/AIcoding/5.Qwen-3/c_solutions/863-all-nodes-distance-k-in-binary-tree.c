#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int *data;
    int size;
    int capacity;
} Vector;

Vector* vector_create() {
    Vector *v = (Vector*)malloc(sizeof(Vector));
    v->data = NULL;
    v->size = 0;
    v->capacity = 0;
    return v;
}

void vector_push(Vector *v, int value) {
    if (v->size == v->capacity) {
        int new_capacity = (v->capacity == 0) ? 1 : v->capacity * 2;
        int *new_data = (int*)realloc(v->data, new_capacity * sizeof(int));
        v->data = new_data;
        v->capacity = new_capacity;
    }
    v->data[v->size++] = value;
}

void vector_free(Vector *v) {
    free(v->data);
    free(v);
}

typedef struct {
    struct TreeNode *node;
    int distance;
} NodeDistance;

typedef struct {
    NodeDistance *data;
    int size;
    int capacity;
} Queue;

Queue* queue_create() {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->data = NULL;
    q->size = 0;
    q->capacity = 0;
    return q;
}

void queue_enqueue(Queue *q, struct TreeNode *node, int distance) {
    if (q->size == q->capacity) {
        int new_capacity = (q->capacity == 0) ? 1 : q->capacity * 2;
        NodeDistance *new_data = (NodeDistance*)realloc(q->data, new_capacity * sizeof(NodeDistance));
        q->data = new_data;
        q->capacity = new_capacity;
    }
    q->data[q->size].node = node;
    q->data[q->size++].distance = distance;
}

NodeDistance* queue_dequeue(Queue *q) {
    if (q->size == 0) return NULL;
    NodeDistance *front = &q->data[0];
    for (int i = 1; i < q->size; i++) {
        q->data[i - 1] = q->data[i];
    }
    q->size--;
    return front;
}

void queue_free(Queue *q) {
    free(q->data);
    free(q);
}

struct TreeNode* findParent(struct TreeNode* root, int target, struct TreeNode **parent) {
    if (!root) return NULL;
    if (root->val == target) {
        *parent = NULL;
        return root;
    }
    struct TreeNode *left = findParent(root->left, target, parent);
    if (left) {
        *parent = root;
        return left;
    }
    struct TreeNode *right = findParent(root->right, target, parent);
    if (right) {
        *parent = root;
        return right;
    }
    return NULL;
}

int* distanceK(struct TreeNode* root, struct TreeNode* target, int k, int* returnSize) {
    Vector *result = vector_create();
    struct TreeNode *parent = NULL;
    struct TreeNode *targetNode = findParent(root, target->val, &parent);

    Queue *queue = queue_create();
    queue_enqueue(queue, targetNode, 0);

    int visited[1000] = {0};
    visited[targetNode->val] = 1;

    while (queue->size > 0) {
        NodeDistance *current = queue_dequeue(queue);
        struct TreeNode *node = current->node;
        int distance = current->distance;

        if (distance == k) {
            vector_push(result, node->val);
        } else if (distance < k) {
            if (node->left && !visited[node->left->val]) {
                visited[node->left->val] = 1;
                queue_enqueue(queue, node->left, distance + 1);
            }
            if (node->right && !visited[node->right->val]) {
                visited[node->right->val] = 1;
                queue_enqueue(queue, node->right, distance + 1);
            }
            if (parent && !visited[parent->val]) {
                visited[parent->val] = 1;
                queue_enqueue(queue, parent, distance + 1);
            }
        }
    }

    *returnSize = result->size;
    int *output = (int*)malloc(result->size * sizeof(int));
    memcpy(output, result->data, result->size * sizeof(int));
    vector_free(result);
    queue_free(queue);
    return output;
}