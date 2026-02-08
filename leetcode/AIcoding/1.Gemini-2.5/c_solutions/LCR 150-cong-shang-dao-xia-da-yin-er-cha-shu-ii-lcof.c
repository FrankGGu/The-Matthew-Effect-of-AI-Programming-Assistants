#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int** levelOrderBottom(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (root == NULL) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    // Max number of nodes for LeetCode binary tree problems is typically 2000.
    // We use this as a safe upper bound for queue and temporary storage sizes.
    #define MAX_NODES 2000

    // Queue for BFS. Using a simple array as a queue.
    struct TreeNode* queue[MAX_NODES];
    int head = 0;
    int tail = 0; // tail points to the next available slot

    // Enqueue the root node
    queue[tail++] = root;
    int current_level_nodes_count = 1; // Number of nodes in the current level

    // Temporary storage for results before reversing
    // Max depth can be MAX_NODES
    int** temp_result_levels = (int**)malloc(sizeof(int*) * MAX_NODES);
    int* temp_column_sizes = (int*)malloc(sizeof(int) * MAX_NODES);
    int num_levels = 0;

    // Perform BFS
    while (head != tail) { // While queue is not empty
        int level_size = current_level_nodes_count;
        current_level_nodes_count = 0; // Reset for next level

        // Allocate memory for current level's values
        int* current_level_vals = (int*)malloc(sizeof(int) * level_size);
        int current_level_idx = 0;

        for (int i = 0; i < level_size; ++i) {
            struct TreeNode* node = queue[head++]; // Dequeue
            current_level_vals[current_level_idx++] = node->val;

            if (node->left != NULL) {
                queue[tail++] = node->left; // Enqueue left child
                current_level_nodes_count++;
            }
            if (node->right != NULL) {
                queue[tail++] = node->right; // Enqueue right child
                current_level_nodes_count++;
            }
        }

        // Store current level's results in temporary storage
        temp_result_levels[num_levels] = current_level_vals;
        temp_column_sizes[num_levels] = level_size;
        num_levels++;
    }

    // Now, temp_result_levels contains levels from top to bottom.
    // We need to reverse them to get bottom to top order.

    *returnSize = num_levels;
    *returnColumnSizes = (int*)malloc(sizeof(int) * num_levels);
    int** final_result = (int**)malloc(sizeof(int*) * num_levels);

    for (int i = 0; i < num_levels; ++i) {
        // Copy levels in reverse order
        final_result[i] = temp_result_levels[num_levels - 1 - i];
        (*returnColumnSizes)[i] = temp_column_sizes[num_levels - 1 - i];
    }

    // Free the temporary arrays themselves, but not the level data they pointed to,
    // as that data is now pointed to by final_result.
    free(temp_result_levels);
    free(temp_column_sizes);

    return final_result;
}