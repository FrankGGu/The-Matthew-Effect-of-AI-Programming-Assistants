#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    char* name;
    struct Node** children;
    int childCount;
} Node;

typedef struct {
    Node* root;
    char** names;
    int size;
    int capacity;
} ThroneInheritance;

Node* createNode(char* name) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->name = strdup(name);
    node->children = NULL;
    node->childCount = 0;
    return node;
}

void addChild(Node* parent, char* name) {
    parent->childCount++;
    parent->children = (Node**)realloc(parent->children, sizeof(Node*) * parent->childCount);
    parent->children[parent->childCount - 1] = createNode(name);
}

ThroneInheritance* throneInheritanceCreate(char* kingName) {
    ThroneInheritance* obj = (ThroneInheritance*)malloc(sizeof(ThroneInheritance));
    obj->root = createNode(kingName);
    obj->names = NULL;
    obj->size = 0;
    obj->capacity = 0;
    return obj;
}

void dfs(Node* node, char*** names, int* size, int* capacity) {
    if (*size >= *capacity) {
        *capacity = (*capacity == 0) ? 1 : *capacity * 2;
        *names = (char**)realloc(*names, sizeof(char*) * *capacity);
    }
    (*names)[*size] = strdup(node->name);
    (*size)++;
    for (int i = 0; i < node->childCount; i++) {
        dfs(node->children[i], names, size, capacity);
    }
}

void throneInheritanceBirth(ThroneInheritance* obj, char* parentName, char* childName) {
    Node* current = obj->root;
    Node* target = NULL;
    Node** stack = (Node**)malloc(sizeof(Node*) * 100);
    int top = 0;
    stack[top++] = current;
    while (top > 0) {
        current = stack[--top];
        if (strcmp(current->name, parentName) == 0) {
            target = current;
            break;
        }
        for (int i = current->childCount - 1; i >= 0; i--) {
            stack[top++] = current->children[i];
        }
    }
    if (target) {
        addChild(target, childName);
    }
    free(stack);
}

void throneInheritanceDeath(ThroneInheritance* obj, char* name) {
    for (int i = 0; i < obj->size; i++) {
        if (strcmp(obj->names[i], name) == 0) {
            free(obj->names[i]);
            for (int j = i; j < obj->size - 1; j++) {
                obj->names[j] = obj->names[j + 1];
            }
            obj->size--;
            break;
        }
    }
}

char** throneInheritanceGetInheritanceList(ThroneInheritance* obj, int* returnSize) {
    *returnSize = 0;
    char** result = NULL;
    int capacity = 0;
    dfs(obj->root, &result, returnSize, &capacity);
    obj->names = result;
    obj->size = *returnSize;
    obj->capacity = capacity;
    return result;
}

void throneInheritanceFree(ThroneInheritance* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->names[i]);
    }
    free(obj->names);
    Node* stack[100];
    int top = 0;
    stack[top++] = obj->root;
    while (top > 0) {
        Node* node = stack[--top];
        for (int i = 0; i < node->childCount; i++) {
            stack[top++] = node->children[i];
        }
        free(node->name);
        free(node->children);
        free(node);
    }
    free(obj);
}