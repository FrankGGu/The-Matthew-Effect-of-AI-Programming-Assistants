#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 100000

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

/** Encodes a tree to a single string. */
char* serialize(struct TreeNode* root) {
    if (root == NULL) return "[]";

    struct TreeNode* queue[MAX_SIZE];
    int front = 0, rear = 0;
    char** elements = (char**)malloc(MAX_SIZE * sizeof(char*));
    int count = 0;

    queue[rear++] = root;

    while (front < rear) {
        struct TreeNode* node = queue[front++];

        if (node == NULL) {
            elements[count] = (char*)malloc(5);
            strcpy(elements[count], "null");
            count++;
        } else {
            elements[count] = (char*)malloc(12);
            sprintf(elements[count], "%d", node->val);
            count++;

            queue[rear++] = node->left;
            queue[rear++] = node->right;
        }
    }

    while (count > 0 && strcmp(elements[count-1], "null") == 0) {
        count--;
    }

    char* result = (char*)malloc(MAX_SIZE);
    strcpy(result, "[");

    for (int i = 0; i < count; i++) {
        strcat(result, elements[i]);
        if (i < count - 1) {
            strcat(result, ",");
        }
        free(elements[i]);
    }

    strcat(result, "]");
    free(elements);

    return result;
}

/** Decodes your encoded data to tree. */
struct TreeNode* deserialize(char* data) {
    if (data == NULL || strcmp(data, "[]") == 0) return NULL;

    int len = strlen(data);
    char* str = (char*)malloc(len + 1);
    strcpy(str, data);

    str[len-1] = '\0';
    char* token = strtok(str + 1, ",");

    if (token == NULL) {
        free(str);
        return NULL;
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = atoi(token);
    root->left = NULL;
    root->right = NULL;

    struct TreeNode* queue[MAX_SIZE];
    int front = 0, rear = 0;
    queue[rear++] = root;

    token = strtok(NULL, ",");

    while (token != NULL && front < rear) {
        struct TreeNode* node = queue[front++];

        if (strcmp(token, "null") != 0) {
            struct TreeNode* left = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            left->val = atoi(token);
            left->left = NULL;
            left->right = NULL;
            node->left = left;
            queue[rear++] = left;
        } else {
            node->left = NULL;
        }

        token = strtok(NULL, ",");
        if (token == NULL) break;

        if (strcmp(token, "null") != 0) {
            struct TreeNode* right = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            right->val = atoi(token);
            right->left = NULL;
            right->right = NULL;
            node->right = right;
            queue[rear++] = right;
        } else {
            node->right = NULL;
        }

        token = strtok(NULL, ",");
    }

    free(str);
    return root;
}

// Your functions will be called as such:
// char* data = serialize(root);
// struct TreeNode* node = deserialize(data);