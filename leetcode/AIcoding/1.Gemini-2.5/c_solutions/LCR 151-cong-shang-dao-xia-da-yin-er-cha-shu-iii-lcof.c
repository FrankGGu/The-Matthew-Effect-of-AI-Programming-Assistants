#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int** zigzagLevelOrder(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (root == NULL) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    // Queue for BFS
    // Max nodes is 2000, so a queue of size 2000 is sufficient.
    struct TreeNode** queue = (struct TreeNode**)malloc(2000 * sizeof(struct TreeNode*));
    int head = 0;
    int tail = 0;

    // Add root to queue
    queue[tail++] = root;

    // Result storage
    int initial_capacity = 10; // Initial capacity for levels
    int** result = (int**)malloc(initial_capacity * sizeof(int*));
    *returnColumnSizes = (int*)malloc(initial_capacity * sizeof(int));
    *returnSize = 0;

    int level_count = 0; // To track if current level is even or odd for zigzag

    while (head != tail) {
        int level_size = tail - head;

        // Resize result arrays if needed
        if (*returnSize == initial_capacity) {
            initial_capacity *= 2;
            result = (int**)realloc(result, initial_capacity * sizeof(int*));
            *returnColumnSizes = (int*)realloc(*returnColumnSizes, initial_capacity * sizeof(int));
        }

        // Allocate memory for current level values
        int* current_level_values = (int*)malloc(level_size * sizeof(int));
        (*returnColumnSizes)[*returnSize] = level_size;

        // Process nodes at current level
        for (int i = 0; i < level_size; ++i) {
            struct TreeNode* node = queue[head++];
            current_level_values[i] = node->val;

            if (node->left) {
                queue[tail++] = node->left;
            }
            if (node->right) {
                queue[tail++] = node->right;
            }
        }

        // Zigzag logic: reverse odd-numbered levels (0-indexed: 1, 3, 5...)
        if (level_count % 2 == 1) {
            for (int i = 0; i < level_size / 2; ++i) {
                int temp = current_level_values[i];
                current_level_values[i] = current_level_values[level_size - 1 - i];
                current_level_values[level_size - 1 - i] = temp;
            }
        }

        result[*returnSize] = current_level_values;
        (*returnSize)++;
        level_count++;
    }

    free(queue); // Free the queue memory

    return result;
}