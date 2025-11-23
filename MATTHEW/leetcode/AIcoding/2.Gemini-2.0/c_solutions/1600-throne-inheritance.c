#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME_LEN 10
#define MAX_CHILDREN 20

typedef struct Node {
    char name[MAX_NAME_LEN];
    struct Node* children[MAX_CHILDREN];
    int numChildren;
    int isDead;
} Node;

typedef struct {
    Node* root;
    char kingName[MAX_NAME_LEN];
} ThroneInheritance;

ThroneInheritance* throneInheritanceCreate(char* kingName) {
    ThroneInheritance* obj = (ThroneInheritance*)malloc(sizeof(ThroneInheritance));
    obj->root = (Node*)malloc(sizeof(Node));
    strcpy(obj->root->name, kingName);
    obj->root->numChildren = 0;
    obj->root->isDead = 0;
    for (int i = 0; i < MAX_CHILDREN; i++) {
        obj->root->children[i] = NULL;
    }
    strcpy(obj->kingName, kingName);
    return obj;
}

void throneInheritanceBirth(ThroneInheritance* obj, char* parentName, char* childName) {
    Node* parentNode = NULL;

    void findParent(Node* node) {
        if (node == NULL) return;
        if (strcmp(node->name, parentName) == 0) {
            parentNode = node;
            return;
        }
        for (int i = 0; i < node->numChildren; i++) {
            findParent(node->children[i]);
            if (parentNode != NULL) return;
        }
    }

    findParent(obj->root);

    Node* childNode = (Node*)malloc(sizeof(Node));
    strcpy(childNode->name, childName);
    childNode->numChildren = 0;
    childNode->isDead = 0;
    for (int i = 0; i < MAX_CHILDREN; i++) {
        childNode->children[i] = NULL;
    }

    parentNode->children[parentNode->numChildren] = childNode;
    parentNode->numChildren++;
}

void throneInheritanceDeath(ThroneInheritance* obj, char* name) {
    void findAndKill(Node* node) {
        if (node == NULL) return;
        if (strcmp(node->name, name) == 0) {
            node->isDead = 1;
            return;
        }
        for (int i = 0; i < node->numChildren; i++) {
            findAndKill(node->children[i]);
        }
    }

    findAndKill(obj->root);
}

char** throneInheritanceGetInheritanceOrder(ThroneInheritance* obj, int* retSize) {
    char** order = (char**)malloc(100000 * sizeof(char*));
    *retSize = 0;

    void dfs(Node* node) {
        if (node == NULL) return;
        if (!node->isDead) {
            order[*retSize] = (char*)malloc((strlen(node->name) + 1) * sizeof(char));
            strcpy(order[*retSize], node->name);
            (*retSize)++;
        }
        for (int i = 0; i < node->numChildren; i++) {
            dfs(node->children[i]);
        }
    }

    dfs(obj->root);

    return order;
}

void throneInheritanceFree(ThroneInheritance* obj) {
    void freeNodes(Node* node) {
        if (node == NULL) return;
        for (int i = 0; i < node->numChildren; i++) {
            freeNodes(node->children[i]);
        }
        free(node);
    }

    freeNodes(obj->root);
    free(obj);
}