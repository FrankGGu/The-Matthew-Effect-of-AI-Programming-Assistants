#include <stdlib.h>
#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#define MAX_QUEUE_SIZE 10001
struct TreeNode* queue[MAX_QUEUE_SIZE];
int head_ptr = 0;
int tail_ptr = 0;

void enqueue(struct TreeNode* node) {
    queue[tail_ptr++] = node;
}

struct TreeNode* dequeue() {
    return queue[head_ptr++];
}

int max(int a, int b) {
    return a > b ? a : b;
}

int* largestValues(struct TreeNode* root, int* returnSize) {
    head_ptr = 0;
    tail_ptr = 0;

    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int* result = NULL;
    int result_capacity = 10;
    result = (int*)malloc(sizeof(int) * result_capacity);
    int result_size = 0;

    enqueue(root);

    while (head_ptr < tail_ptr) {
        int level_size = tail_ptr - head_ptr;
        int max_val_in_row = INT_MIN;

        for (int i = 0; i < level_size; i++) {
            struct TreeNode* current_node = dequeue();

            max_val_in_row = max(max_val_in_row, current_node->val);

            if (current_node->left != NULL) {
                enqueue(current_node->left);
            }
            if (current_node->right != NULL) {
                enqueue(current_node->right);
            }
        }

        if (result_size == result_capacity) {
            result_capacity *= 2;
            result = (int*)realloc(result, sizeof(int) * result_capacity);
        }
        result[result_size++] = max_val_in_row;
    }

    *returnSize = result_size;
    return result;
}