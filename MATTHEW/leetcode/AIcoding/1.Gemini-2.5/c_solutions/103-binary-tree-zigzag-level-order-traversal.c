#include <stdlib.h>

#define MAX_NODES 2001 

int** zigzagLevelOrder(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    // Initialize return values
    *returnSize = 0;
    *returnColumnSizes = NULL;

    // If the tree is empty, return an empty result
    if (root == NULL) {
        return NULL;
    }

    // Allocate memory for the queue, which stores TreeNode pointers for BFS
    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * MAX_NODES);
    int front = 0; // Pointer to the front of the queue
    int rear = 0;  // Pointer to the rear of the queue

    // Allocate memory for the overall result array (array of integer arrays)
    int** result = (int**)malloc(sizeof(int*) * MAX_NODES);
    // Allocate memory for the array that stores the size of each level's array
    *returnColumnSizes = (int*)malloc(sizeof(int) * MAX_NODES);

    // Enqueue the root node to start the BFS
    queue[rear++] = root;
    int level = 0; // Current level index, starting from 0

    // Perform Breadth-First Search
    while (front < rear) {
        int currentLevelSize = rear - front; // Number of nodes at the current level

        // Allocate memory for the integer values of the current level
        int* currentLevelVals = (int*)malloc(sizeof(int) * currentLevelSize);

        // Store the size of the current level's array
        (*returnColumnSizes)[*returnSize] = currentLevelSize;

        // Process all nodes at the current level
        for (int i = 0; i < currentLevelSize; i++) {
            struct TreeNode* node = queue[front++]; // Dequeue a node
            currentLevelVals[i] = node->val;      // Store its value

            // Enqueue left child if it exists
            if (node->left) {
                queue[rear++] = node->left;
            }
            // Enqueue right child if it exists
            if (node->right) {
                queue[rear++] = node->right;
            }
        }

        // Apply zigzag order: if the level is odd, reverse the current level's values
        if (level % 2 == 1) {
            for (int i = 0; i < currentLevelSize / 2; i++) {
                int temp = currentLevelVals[i];
                currentLevelVals[i] = currentLevelVals[currentLevelSize - 1 - i];
                currentLevelVals[currentLevelSize - 1 - i] = temp;
            }
        }

        // Add the current level's values array to the overall result
        result[*returnSize] = currentLevelVals;
        (*returnSize)++; // Increment the total number of levels found
        level++;         // Move to the next level
    }

    // Free the memory allocated for the queue
    free(queue);

    // Return the final result
    return result;
}