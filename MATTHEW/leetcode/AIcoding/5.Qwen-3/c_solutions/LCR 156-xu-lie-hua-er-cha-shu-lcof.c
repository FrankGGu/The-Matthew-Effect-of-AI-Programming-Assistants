#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

char* serialize(struct TreeNode* root) {
    if (!root) return NULL;
    char* result = (char*)malloc(10000 * sizeof(char));
    char* p = result;
    void* queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = root;
    while (front < rear) {
        struct TreeNode* node = queue[front++];
        if (node) {
            sprintf(p, "%d,", node->val);
            p += strlen(p);
            queue[rear++] = node->left;
            queue[rear++] = node->right;
        } else {
            strcpy(p, "null,");
            p += 5;
        }
    }
    p[-1] = '\0';
    return result;
}

struct TreeNode* deserialize(char* data) {
    if (!data || strcmp(data, "") == 0) return NULL;
    char* token = strtok(data, ",");
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(TreeNode));
    root->val = atoi(token);
    root->left = NULL;
    root->right = NULL;
    void* queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = root;
    while (front < rear) {
        struct TreeNode* node = queue[front++];
        if (token = strtok(NULL, ",")) {
            if (strcmp(token, "null") != 0) {
                node->left = (struct TreeNode*)malloc(sizeof(TreeNode));
                node->left->val = atoi(token);
                node->left->left = NULL;
                node->left->right = NULL;
                queue[rear++] = node->left;
            }
        }
        if (token = strtok(NULL, ",")) {
            if (strcmp(token, "null") != 0) {
                node->right = (struct TreeNode*)malloc(sizeof(TreeNode));
                node->right->val = atoi(token);
                node->right->left = NULL;
                node->right->right = NULL;
                queue[rear++] = node->right;
            }
        }
    }
    return root;
}