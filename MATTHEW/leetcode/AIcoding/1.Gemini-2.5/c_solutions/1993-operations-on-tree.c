#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* parent;
    int* lockedBy;
    int** children;
    int* childrenCount;
    int n;
} LockingTree;

static bool checkAncestors(LockingTree* obj, int num);
static bool hasLockedDescendant(LockingTree* obj, int num);
static void unlockAllDescendants(LockingTree* obj, int num);

LockingTree* lockingTreeCreate(int* parent, int parentSize) {
    LockingTree* obj = (LockingTree*)malloc(sizeof(LockingTree));
    obj->n = parentSize;

    obj->parent = (int*)malloc(sizeof(int) * obj->n);
    for (int i = 0; i < obj->n; ++i) {
        obj->parent[i] = parent[i];
    }

    obj->lockedBy = (int*)malloc(sizeof(int) * obj->n);
    for (int i = 0; i < obj->n; ++i) {
        obj->lockedBy[i] = -1;
    }

    obj->children = (int**)malloc(sizeof(int*) * obj->n);
    obj->childrenCount = (int*)calloc(obj->n, sizeof(int));

    for (int i = 1; i < obj->n; ++i) {
        obj->childrenCount[parent[i]]++;
    }

    for (int i = 0; i < obj->n; ++i) {
        obj->children[i] = (int*)malloc(sizeof(int) * obj->childrenCount[i]);
    }

    int* currentChildIndex = (int*)calloc(obj->n, sizeof(int));
    for (int i = 1; i < obj->n; ++i) {
        int p = parent[i];
        obj->children[p][currentChildIndex[p]++] = i;
    }
    free(currentChildIndex);

    return obj;
}

bool lockingTreeLock(LockingTree* obj, int num, int user) {
    if (obj->lockedBy[num] == -1) {
        obj->lockedBy[num] = user;
        return true;
    }
    return false;
}

bool lockingTreeUnlock(LockingTree* obj, int num, int user) {
    if (obj->lockedBy[num] == user) {
        obj->lockedBy[num] = -1;
        return true;
    }
    return false;
}

static bool checkAncestors(LockingTree* obj, int num) {
    int curr = obj->parent[num];
    while (curr != -1) {
        if (obj->lockedBy[curr] != -1) {
            return false;
        }
        curr = obj->parent[curr];
    }
    return true;
}

static bool hasLockedDescendant(LockingTree* obj, int num) {
    for (int i = 0; i < obj->childrenCount[num]; ++i) {
        int child = obj->children[num][i];
        if (obj->lockedBy[child] != -1) {
            return true;
        }
        if (hasLockedDescendant(obj, child)) {
            return true;
        }
    }
    return false;
}

static void unlockAllDescendants(LockingTree* obj, int num) {
    for (int i = 0; i < obj->childrenCount[num]; ++i) {
        int child = obj->children[num][i];
        obj->lockedBy[child] = -1;
        unlockAllDescendants(obj, child);
    }
}

bool lockingTreeUpgrade(LockingTree* obj, int num, int user) {
    if (obj->lockedBy[num] != -1) {
        return false;
    }

    if (!checkAncestors(obj, num)) {
        return false;
    }

    if (!hasLockedDescendant(obj, num)) {
        return false;
    }

    obj->lockedBy[num] = user;
    unlockAllDescendants(obj, num);

    return true;
}

void lockingTreeFree(LockingTree* obj) {
    free(obj->parent);
    free(obj->lockedBy);
    for (int i = 0; i < obj->n; ++i) {
        free(obj->children[i]);
    }
    free(obj->children);
    free(obj->childrenCount);
    free(obj);
}