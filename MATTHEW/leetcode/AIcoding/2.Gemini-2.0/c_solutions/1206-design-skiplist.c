#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LEVEL 32
#define P 0.5

typedef struct SkiplistNode {
    int val;
    struct SkiplistNode **forward;
} SkiplistNode;

typedef struct {
    SkiplistNode *header;
    int level;
} Skiplist;

SkiplistNode* skiplistNodeCreate(int val, int level) {
    SkiplistNode *node = (SkiplistNode*)malloc(sizeof(SkiplistNode));
    node->val = val;
    node->forward = (SkiplistNode**)malloc(sizeof(SkiplistNode*) * (level + 1));
    for (int i = 0; i <= level; i++) {
        node->forward[i] = NULL;
    }
    return node;
}

Skiplist* skiplistCreate() {
    srand(time(NULL));
    Skiplist *obj = (Skiplist*)malloc(sizeof(Skiplist));
    obj->level = 0;
    obj->header = skiplistNodeCreate(-1, MAX_LEVEL);
    return obj;
}

int randomLevel() {
    int level = 0;
    while (rand() < RAND_MAX * P && level < MAX_LEVEL)
        level++;
    return level;
}

bool skiplistSearch(Skiplist* obj, int target) {
    SkiplistNode *current = obj->header;
    for (int i = obj->level; i >= 0; i--) {
        while (current->forward[i] != NULL && current->forward[i]->val < target) {
            current = current->forward[i];
        }
    }
    current = current->forward[0];
    return current != NULL && current->val == target;
}

void skiplistAdd(Skiplist* obj, int num) {
    SkiplistNode *update[MAX_LEVEL + 1];
    SkiplistNode *current = obj->header;
    for (int i = obj->level; i >= 0; i--) {
        while (current->forward[i] != NULL && current->forward[i]->val < num) {
            current = current->forward[i];
        }
        update[i] = current;
    }
    current = current->forward[0];

    if (current == NULL || current->val != num) {
        int level = randomLevel();
        if (level > obj->level) {
            for (int i = obj->level + 1; i <= level; i++) {
                update[i] = obj->header;
            }
            obj->level = level;
        }
        SkiplistNode *newNode = skiplistNodeCreate(num, level);
        for (int i = 0; i <= level; i++) {
            newNode->forward[i] = update[i]->forward[i];
            update[i]->forward[i] = newNode;
        }
    }
}

bool skiplistErase(Skiplist* obj, int num) {
    SkiplistNode *update[MAX_LEVEL + 1];
    SkiplistNode *current = obj->header;
    for (int i = obj->level; i >= 0; i--) {
        while (current->forward[i] != NULL && current->forward[i]->val < num) {
            current = current->forward[i];
        }
        update[i] = current;
    }
    current = current->forward[0];

    if (current != NULL && current->val == num) {
        for (int i = 0; i <= obj->level; i++) {
            if (update[i]->forward[i] != current)
                break;
            update[i]->forward[i] = current->forward[i];
        }

        while (obj->level > 0 && obj->header->forward[obj->level] == NULL) {
            obj->level--;
        }

        free(current->forward);
        free(current);
        return true;
    }
    return false;
}

void skiplistFree(Skiplist* obj) {
    SkiplistNode *current = obj->header;
    while (current != NULL) {
        SkiplistNode *next = current->forward[0];
        free(current->forward);
        free(current);
        current = next;
    }
    free(obj);
}