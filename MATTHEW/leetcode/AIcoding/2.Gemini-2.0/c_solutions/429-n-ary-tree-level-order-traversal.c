#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    int val;
    int numChildren;
    struct Node** children;
};

typedef struct {
    struct Node *node;
    int level;
} QueueNode;

int** levelOrder(struct Node* root, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    if (!root) return NULL;

    int** result = (int**)malloc(1000 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(1000 * sizeof(int));

    QueueNode queue[10000];
    int head = 0, tail = 0;

    QueueNode rootNode;
    rootNode.node = root;
    rootNode.level = 0;
    queue[tail++] = rootNode;

    while (head < tail) {
        QueueNode current = queue[head++];
        struct Node* node = current.node;
        int level = current.level;

        if (level >= *returnSize) {
            result[*returnSize] = (int*)malloc(1000 * sizeof(int));
            (*returnColumnSizes)[*returnSize] = 0;
            *returnSize += 1;
        }

        result[level][(*returnColumnSizes)[level]++] = node->val;

        if (node->numChildren > 0) {
            for (int i = 0; i < node->numChildren; i++) {
                if (node->children[i]) {
                    QueueNode childNode;
                    childNode.node = node->children[i];
                    childNode.level = level + 1;
                    queue[tail++] = childNode;
                }
            }
        }
    }

    return result;
}