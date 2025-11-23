#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* smallestSubtreeWithAllDeepest(struct TreeNode* root) {
    struct TreeNode* result = NULL;
    int maxDepth = 0;

    typedef struct {
        struct TreeNode* node;
        int depth;
    } NodeDepth;

    NodeDepth* queue = (NodeDepth*)malloc(sizeof(NodeDepth) * 10000);
    int front = 0, rear = 0;

    if (root == NULL) return NULL;

    queue[rear].node = root;
    queue[rear++].depth = 0;

    while (front < rear) {
        NodeDepth current = queue[front++];
        int depth = current.depth;
        struct TreeNode* node = current.node;

        if (depth > maxDepth) {
            maxDepth = depth;
            result = node;
        } else if (depth == maxDepth) {
            result = NULL;
        }

        if (node->left) {
            queue[rear].node = node->left;
            queue[rear++].depth = depth + 1;
        }
        if (node->right) {
            queue[rear].node = node->right;
            queue[rear++].depth = depth + 1;
        }
    }

    free(queue);
    return result;
}