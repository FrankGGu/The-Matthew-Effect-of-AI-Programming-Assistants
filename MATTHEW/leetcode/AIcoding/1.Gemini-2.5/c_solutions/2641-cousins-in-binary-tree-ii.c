#include <stdlib.h>
#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode** data;
    int head;
    int tail;
    int capacity;
} Queue;

void queue_init(Queue* q, int initial_capacity) {
    q->data = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * initial_capacity);
    q->head = 0;
    q->tail = 0;
    q->capacity = initial_capacity;
}

void queue_enqueue(Queue* q, struct TreeNode* node) {
    if (q->tail == q->capacity) {
        q->capacity *= 2;
        q->data = (struct TreeNode**)realloc(q->data, sizeof(struct TreeNode*) * q->capacity);
    }
    q->data[q->tail++] = node;
}

struct TreeNode* queue_dequeue(Queue* q) {
    return q->data[q->head++];
}

bool queue_is_empty(Queue* q) {
    return q->head == q->tail;
}

int queue_size(Queue* q) {
    return q->tail - q->head;
}

void queue_free(Queue* q) {
    free(q->data);
}

struct TreeNode* replaceValueInTree(struct TreeNode* root) {
    if (root == NULL) {
        return NULL;
    }

    root->val = 0;

    Queue q;
    queue_init(&q, 1024);
    queue_enqueue(&q, root);

    while (!queue_is_empty(&q)) {
        int level_size = queue_size(&q);

        struct TreeNode** current_level_parents = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * level_size);
        long long sum_of_next_level_original_values = 0;

        for (int i = 0; i < level_size; ++i) {
            struct TreeNode* parent = queue_dequeue(&q);
            current_level_parents[i] = parent;

            if (parent->left != NULL) {
                sum_of_next_level_original_values += parent->left->val;
            }
            if (parent->right != NULL) {
                sum_of_next_level_original_values += parent->right->val;
            }
        }

        for (int i = 0; i < level_size; ++i) {
            struct TreeNode* parent = current_level_parents[i];

            long long sibling_sum_original_values = 0;
            if (parent->left != NULL) {
                sibling_sum_original_values += parent->left->val;
            }
            if (parent->right != NULL) {
                sibling_sum_original_values += parent->right->val;
            }

            if (parent->left != NULL) {
                parent->left->val = sum_of_next_level_original_values - sibling_sum_original_values;
                queue_enqueue(&q, parent->left);
            }
            if (parent->right != NULL) {
                parent->right->val = sum_of_next_level_original_values - sibling_sum_original_values;
                queue_enqueue(&q, parent->right);
            }
        }
        free(current_level_parents);
    }

    queue_free(&q);
    return root;
}