#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* rightSideView(struct TreeNode* root, int* returnSize) {
    *returnSize = 0;

    if (root == NULL) {
        return NULL;
    }

    #define MAX_QUEUE_NODES 10001
    struct TreeNode* queue[MAX_QUEUE_NODES];
    int head = 0;
    int tail = 0;

    #define INITIAL_RESULT_CAPACITY 100
    int* result = (int*)malloc(INITIAL_RESULT_CAPACITY * sizeof(int));
    int result_capacity = INITIAL_RESULT_CAPACITY;
    int result_size = 0;

    queue[tail++] = root;

    while (head != tail) {
        int level_size = tail - head;

        for (int i = 0; i < level_size; i++) {
            struct TreeNode* current_node = queue[head++];

            if (i == level_size - 1) {
                if (result_size == result_capacity) {
                    result_capacity *= 2;
                    result = (int*)realloc(result, result_capacity * sizeof(int));
                    if (result == NULL) {
                        *returnSize = 0;
                        return NULL;
                    }
                }
                result[result_size++] = current_node->val;
            }

            if (current_node->left != NULL) {
                queue[tail++] = current_node->left;
            }
            if (current_node->right != NULL) {
                queue[tail++] = current_node->right;
            }
        }
    }

    *returnSize = result_size;

    if (result_size < result_capacity) {
        result = (int*)realloc(result, result_size * sizeof(int));
        if (result == NULL) {
            *returnSize = 0;
            return NULL;
        }
    }

    return result;
}