#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NODES 10000

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    char* data;
    int size;
    int capacity;
} StringBuilder;

void sb_init(StringBuilder* sb) {
    sb->capacity = 16;
    sb->data = (char*)malloc(sb->capacity);
    sb->size = 0;
}

void sb_append(StringBuilder* sb, const char* str) {
    int len = strlen(str);
    if (sb->size + len + 1 >= sb->capacity) {
        sb->capacity *= 2;
        sb->data = (char*)realloc(sb->data, sb->capacity);
    }
    strcpy(sb->data + sb->size, str);
    sb->size += len;
}

/** Encodes a tree to a single string. */
char* serialize(struct TreeNode* root) {
    if (root == NULL) return "[]";

    StringBuilder sb;
    sb_init(&sb);
    sb_append(&sb, "[");

    struct TreeNode* queue[MAX_NODES];
    int front = 0, rear = 0;
    queue[rear++] = root;

    int null_count = 0;
    while (front < rear) {
        struct TreeNode* node = queue[front++];

        if (node == NULL) {
            null_count++;
            continue;
        }

        if (sb.size > 1) sb_append(&sb, ",");

        char num[20];
        sprintf(num, "%d", node->val);
        sb_append(&sb, num);

        queue[rear++] = node->left;
        queue[rear++] = node->right;
        null_count = 0;
    }

    sb_append(&sb, "]");
    return sb.data;
}

/** Decodes your encoded data to tree. */
struct TreeNode* deserialize(char* data) {
    if (data == NULL || strcmp(data, "[]") == 0) return NULL;

    int len = strlen(data);
    char* copy = (char*)malloc(len + 1);
    strcpy(copy, data);

    char* tokens[MAX_NODES];
    int token_count = 0;

    char* token = strtok(copy + 1, ",");
    while (token != NULL) {
        tokens[token_count++] = token;
        token = strtok(NULL, ",");
    }

    if (token_count > 0) {
        char* last = tokens[token_count - 1];
        int last_len = strlen(last);
        if (last[last_len - 1] == ']') {
            last[last_len - 1] = '\0';
        }
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = atoi(tokens[0]);
    root->left = root->right = NULL;

    struct TreeNode* queue[MAX_NODES];
    int front = 0, rear = 0;
    queue[rear++] = root;

    int i = 1;
    while (front < rear && i < token_count) {
        struct TreeNode* node = queue[front++];

        if (strcmp(tokens[i], "null") != 0) {
            struct TreeNode* left = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            left->val = atoi(tokens[i]);
            left->left = left->right = NULL;
            node->left = left;
            queue[rear++] = left;
        }
        i++;

        if (i < token_count && strcmp(tokens[i], "null") != 0) {
            struct TreeNode* right = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            right->val = atoi(tokens[i]);
            right->left = right->right = NULL;
            node->right = right;
            queue[rear++] = right;
        }
        i++;
    }

    free(copy);
    return root;
}

// Your functions will be called as such:
// char* data = serialize(root);
// struct TreeNode* node = deserialize(data);