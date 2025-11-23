#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int n;
    int *parent;
    bool *locked;
    int *locked_by;
    int *children_count;
    int **children;
} LockingTree;

LockingTree* lockingTreeCreate(int* parent, int parentSize) {
    LockingTree* obj = (LockingTree*)malloc(sizeof(LockingTree));
    obj->n = parentSize;
    obj->parent = parent;
    obj->locked = (bool*)calloc(parentSize, sizeof(bool));
    obj->locked_by = (int*)calloc(parentSize, sizeof(int));
    obj->children_count = (int*)calloc(parentSize, sizeof(int));
    obj->children = (int**)malloc(parentSize * sizeof(int*));
    for (int i = 0; i < parentSize; i++) {
        obj->children[i] = (int*)malloc(parentSize * sizeof(int));
    }

    for (int i = 0; i < parentSize; i++) {
        if (parent[i] != -1) {
            obj->children[parent[i]][obj->children_count[parent[i]]++] = i;
        }
    }

    return obj;
}

bool lock(LockingTree* obj, int num, int user) {
    if (obj->locked[num]) {
        return false;
    }
    obj->locked[num] = true;
    obj->locked_by[num] = user;
    return true;
}

bool unlock(LockingTree* obj, int num, int user) {
    if (!obj->locked[num] || obj->locked_by[num] != user) {
        return false;
    }
    obj->locked[num] = false;
    return true;
}

bool upgrade(LockingTree* obj, int num, int user) {
    if (obj->locked[num]) {
        return false;
    }

    int ancestor = obj->parent[num];
    while (ancestor != -1) {
        if (obj->locked[ancestor]) {
            return false;
        }
        ancestor = obj->parent[ancestor];
    }

    int count = 0;
    bool has_locked_descendant = false;
    int stack[obj->n];
    int top = -1;
    stack[++top] = num;

    while (top >= 0) {
        int node = stack[top--];
        for (int i = 0; i < obj->children_count[node]; i++) {
            stack[++top] = obj->children[node][i];
        }
    }

    top = -1;
    stack[++top] = num;

    while (top >= 0) {
        int node = stack[top--];
        if (obj->locked[node]) {
            has_locked_descendant = true;
            count++;
        }
        for (int i = 0; i < obj->children_count[node]; i++) {
            stack[++top] = obj->children[node][i];
        }
    }

    if (!has_locked_descendant) {
        return false;
    }

    top = -1;
    stack[++top] = num;

    while (top >= 0) {
        int node = stack[top--];
        if (obj->locked[node]) {
            obj->locked[node] = false;
        }
        for (int i = 0; i < obj->children_count[node]; i++) {
            stack[++top] = obj->children[node][i];
        }
    }

    obj->locked[num] = true;
    obj->locked_by[num] = user;

    return true;
}

void lockingTreeFree(LockingTree* obj) {
    for (int i = 0; i < obj->n; i++) {
        free(obj->children[i]);
    }
    free(obj->children);
    free(obj->locked);
    free(obj->locked_by);
    free(obj->children_count);
    free(obj);
}