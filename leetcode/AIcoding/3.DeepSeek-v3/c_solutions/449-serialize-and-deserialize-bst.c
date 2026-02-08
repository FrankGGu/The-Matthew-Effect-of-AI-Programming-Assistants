#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

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
    sb->data = malloc(sb->capacity);
    sb->size = 0;
}

void sb_append(StringBuilder* sb, const char* str) {
    int len = strlen(str);
    if (sb->size + len + 1 >= sb->capacity) {
        sb->capacity *= 2;
        sb->data = realloc(sb->data, sb->capacity);
    }
    memcpy(sb->data + sb->size, str, len);
    sb->size += len;
    sb->data[sb->size] = '\0';
}

void sb_free(StringBuilder* sb) {
    free(sb->data);
}

void preorder(struct TreeNode* root, StringBuilder* sb) {
    if (!root) return;

    char num[20];
    sprintf(num, "%d,", root->val);
    sb_append(sb, num);

    preorder(root->left, sb);
    preorder(root->right, sb);
}

/** Encodes a tree to a single string. */
char* serialize(struct TreeNode* root) {
    StringBuilder sb;
    sb_init(&sb);
    preorder(root, &sb);
    char* result = malloc(sb.size + 1);
    strcpy(result, sb.data);
    sb_free(&sb);
    return result;
}

struct TreeNode* build(int* preorder, int* idx, int size, int min, int max) {
    if (*idx >= size) return NULL;

    int val = preorder[*idx];
    if (val < min || val > max) return NULL;

    struct TreeNode* node = malloc(sizeof(struct TreeNode));
    node->val = val;
    (*idx)++;

    node->left = build(preorder, idx, size, min, val);
    node->right = build(preorder, idx, size, val, max);

    return node;
}

/** Decodes your encoded data to tree. */
struct TreeNode* deserialize(char* data) {
    if (!data || strlen(data) == 0) return NULL;

    int preorder[MAX_NODES];
    int count = 0;

    char* token = strtok(data, ",");
    while (token) {
        preorder[count++] = atoi(token);
        token = strtok(NULL, ",");
    }

    int idx = 0;
    return build(preorder, &idx, count, -1, 10001);
}

// Your functions will be called as such:
// char* data = serialize(root);
// deserialize(data);