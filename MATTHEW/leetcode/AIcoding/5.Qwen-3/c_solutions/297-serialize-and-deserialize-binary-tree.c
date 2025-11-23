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
    char* ptr = result;
    void* queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = root;
    while (front < rear) {
        struct TreeNode* node = (struct TreeNode*)queue[front++];
        if (node) {
            sprintf(ptr, "%d,", node->val);
            ptr += strlen(ptr);
            queue[rear++] = node->left;
            queue[rear++] = node->right;
        } else {
            sprintf(ptr, "null,");
            ptr += strlen(ptr);
        }
    }
    ptr[-1] = '\0';
    return result;
}

struct TreeNode* deserialize(char* data) {
    if (!data || strlen(data) == 0) return NULL;
    char* token = strtok(data, ",");
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(TreeNode));
    root->val = atoi(token);
    void* queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = root;
    while (front < rear) {
        struct TreeNode* node = (struct TreeNode*)queue[front++];
        token = strtok(NULL, ",");
        if (token && strcmp(token, "null") != 0) {
            node->left = (struct TreeNode*)malloc(sizeof(TreeNode));
            node->left->val = atoi(token);
            queue[rear++] = node->left;
        } else {
            node->left = NULL;
        }
        token = strtok(NULL, ",");
        if (token && strcmp(token, "null") != 0) {
            node->right = (struct TreeNode*)malloc(sizeof(TreeNode));
            node->right->val = atoi(token);
            queue[rear++] = node->right;
        } else {
            node->right = NULL;
        }
    }
    return root;
}