#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int widthOfBinaryTree(struct TreeNode* root) {
    if (!root) return 0;

    int maxWidth = 0;
    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 3001);
    unsigned long long* indexQueue = (unsigned long long*)malloc(sizeof(unsigned long long) * 3001);
    int head = 0, tail = 0;

    queue[tail] = root;
    indexQueue[tail] = 1;
    tail++;

    while (head < tail) {
        int size = tail - head;
        unsigned long long left = indexQueue[head];
        unsigned long long right = indexQueue[tail - 1];
        maxWidth = (maxWidth > (int)(right - left + 1)) ? maxWidth : (int)(right - left + 1);

        for (int i = 0; i < size; i++) {
            struct TreeNode* node = queue[head];
            unsigned long long index = indexQueue[head];
            head++;

            if (node->left) {
                queue[tail] = node->left;
                indexQueue[tail] = index * 2;
                tail++;
            }
            if (node->right) {
                queue[tail] = node->right;
                indexQueue[tail] = index * 2 + 1;
                tail++;
            }
        }
    }

    free(queue);
    free(indexQueue);
    return maxWidth;
}