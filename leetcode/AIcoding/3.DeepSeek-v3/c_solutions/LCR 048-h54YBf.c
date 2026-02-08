#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 20000

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    char data[MAX_SIZE];
    int size;
} Codec;

Codec* codecCreate() {
    Codec* obj = (Codec*)malloc(sizeof(Codec));
    obj->size = 0;
    return obj;
}

void serializeHelper(struct TreeNode* root, Codec* obj) {
    if (root == NULL) {
        if (obj->size > 0) {
            strcat(obj->data, "null,");
            obj->size += 5;
        } else {
            strcpy(obj->data, "null,");
            obj->size = 5;
        }
        return;
    }

    char buffer[20];
    sprintf(buffer, "%d,", root->val);
    if (obj->size > 0) {
        strcat(obj->data, buffer);
        obj->size += strlen(buffer);
    } else {
        strcpy(obj->data, buffer);
        obj->size = strlen(buffer);
    }

    serializeHelper(root->left, obj);
    serializeHelper(root->right, obj);
}

char* serialize(struct TreeNode* root) {
    Codec* obj = codecCreate();
    serializeHelper(root, obj);
    if (obj->size > 0) {
        obj->data[obj->size - 1] = '\0';
    }
    char* result = (char*)malloc(obj->size + 1);
    strcpy(result, obj->data);
    free(obj);
    return result;
}

struct TreeNode* deserializeHelper(char** data) {
    if (data == NULL || *data == NULL) {
        return NULL;
    }

    char* token = strsep(data, ",");
    if (token == NULL || strcmp(token, "null") == 0) {
        return NULL;
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = atoi(token);
    root->left = deserializeHelper(data);
    root->right = deserializeHelper(data);
    return root;
}

struct TreeNode* deserialize(char* data) {
    if (data == NULL) {
        return NULL;
    }
    char* input = strdup(data);
    struct TreeNode* root = deserializeHelper(&input);
    free(input);
    return root;
}

void codecFree(Codec* obj) {
    free(obj);
}