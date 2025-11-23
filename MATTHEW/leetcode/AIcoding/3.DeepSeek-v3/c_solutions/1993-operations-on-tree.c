typedef struct {
    int* children;
    int childrenSize;
    int childrenCapacity;
} Node;

typedef struct {
    Node* nodes;
    int size;
    int* lockedBy;
    int* parent;
} LockingTree;

LockingTree* lockingTreeCreate(int* parent, int parentSize) {
    LockingTree* obj = malloc(sizeof(LockingTree));
    obj->size = parentSize;
    obj->nodes = malloc(parentSize * sizeof(Node));
    obj->lockedBy = malloc(parentSize * sizeof(int));
    obj->parent = malloc(parentSize * sizeof(int));

    for (int i = 0; i < parentSize; i++) {
        obj->nodes[i].children = NULL;
        obj->nodes[i].childrenSize = 0;
        obj->nodes[i].childrenCapacity = 0;
        obj->lockedBy[i] = -1;
        obj->parent[i] = parent[i];
    }

    for (int i = 1; i < parentSize; i++) {
        int p = parent[i];
        if (obj->nodes[p].childrenSize >= obj->nodes[p].childrenCapacity) {
            int newCapacity = obj->nodes[p].childrenCapacity == 0 ? 4 : obj->nodes[p].childrenCapacity * 2;
            int* newChildren = realloc(obj->nodes[p].children, newCapacity * sizeof(int));
            obj->nodes[p].children = newChildren;
            obj->nodes[p].childrenCapacity = newCapacity;
        }
        obj->nodes[p].children[obj->nodes[p].childrenSize++] = i;
    }

    return obj;
}

bool lockingTreeLock(LockingTree* obj, int num, int user) {
    if (obj->lockedBy[num] != -1) {
        return false;
    }
    obj->lockedBy[num] = user;
    return true;
}

bool lockingTreeUnlock(LockingTree* obj, int num, int user) {
    if (obj->lockedBy[num] != user) {
        return false;
    }
    obj->lockedBy[num] = -1;
    return true;
}

bool hasLockedDescendant(LockingTree* obj, int num) {
    if (obj->lockedBy[num] != -1) {
        return true;
    }
    for (int i = 0; i < obj->nodes[num].childrenSize; i++) {
        int child = obj->nodes[num].children[i];
        if (hasLockedDescendant(obj, child)) {
            return true;
        }
    }
    return false;
}

void unlockDescendants(LockingTree* obj, int num) {
    obj->lockedBy[num] = -1;
    for (int i = 0; i < obj->nodes[num].childrenSize; i++) {
        int child = obj->nodes[num].children[i];
        unlockDescendants(obj, child);
    }
}

bool lockingTreeUpgrade(LockingTree* obj, int num, int user) {
    if (obj->lockedBy[num] != -1) {
        return false;
    }

    int current = obj->parent[num];
    while (current != -1) {
        if (obj->lockedBy[current] != -1) {
            return false;
        }
        current = obj->parent[current];
    }

    if (!hasLockedDescendant(obj, num)) {
        return false;
    }

    unlockDescendants(obj, num);
    obj->lockedBy[num] = user;
    return true;
}

void lockingTreeFree(LockingTree* obj) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->nodes[i].children != NULL) {
            free(obj->nodes[i].children);
        }
    }
    free(obj->nodes);
    free(obj->lockedBy);
    free(obj->parent);
    free(obj);
}

/**
 * Your LockingTree struct will be instantiated and called as such:
 * LockingTree* obj = lockingTreeCreate(parent, parentSize);
 * bool param_1 = lockingTreeLock(obj, num, user);

 * bool param_2 = lockingTreeUnlock(obj, num, user);

 * bool param_3 = lockingTreeUpgrade(obj, num, user);

 * lockingTreeFree(obj);
*/