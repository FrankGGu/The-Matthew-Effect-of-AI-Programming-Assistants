#include <stdlib.h>
#include <stdbool.h>

#define MAX_LEVEL 16

typedef struct SkiplistNode {
    int value;
    struct SkiplistNode **forward;
} SkiplistNode;

typedef struct Skiplist {
    SkiplistNode *header;
    int level;
} Skiplist;

Skiplist* skiplistCreate() {
    Skiplist *skiplist = (Skiplist *)malloc(sizeof(Skiplist));
    skiplist->header = (SkiplistNode *)malloc(sizeof(SkiplistNode));
    skiplist->header->forward = (SkiplistNode **)malloc(sizeof(SkiplistNode *) * MAX_LEVEL);
    for (int i = 0; i < MAX_LEVEL; i++) {
        skiplist->header->forward[i] = NULL;
    }
    skiplist->level = 0;
    return skiplist;
}

int randomLevel() {
    int level = 0;
    while (level < MAX_LEVEL - 1 && rand() % 2) {
        level++;
    }
    return level;
}

void skiplistAdd(Skiplist* obj, int num) {
    SkiplistNode *current = obj->header;
    SkiplistNode *update[MAX_LEVEL];
    for (int i = obj->level; i >= 0; i--) {
        while (current->forward[i] != NULL && current->forward[i]->value < num) {
            current = current->forward[i];
        }
        update[i] = current;
    }
    current = current->forward[0];
    if (current == NULL || current->value != num) {
        int newLevel = randomLevel();
        if (newLevel > obj->level) {
            for (int i = obj->level + 1; i <= newLevel; i++) {
                update[i] = obj->header;
            }
            obj->level = newLevel;
        }
        SkiplistNode *newNode = (SkiplistNode *)malloc(sizeof(SkiplistNode));
        newNode->value = num;
        newNode->forward = (SkiplistNode **)malloc(sizeof(SkiplistNode *) * (newLevel + 1));
        for (int i = 0; i <= newLevel; i++) {
            newNode->forward[i] = NULL;
        }
        for (int i = 0; i <= newLevel; i++) {
            newNode->forward[i] = update[i]->forward[i];
            update[i]->forward[i] = newNode;
        }
    }
}

bool skiplistSearch(Skiplist* obj, int num) {
    SkiplistNode *current = obj->header;
    for (int i = obj->level; i >= 0; i--) {
        while (current->forward[i] != NULL && current->forward[i]->value < num) {
            current = current->forward[i];
        }
    }
    current = current->forward[0];
    return current != NULL && current->value == num;
}

bool skiplistErase(Skiplist* obj, int num) {
    SkiplistNode *current = obj->header;
    SkiplistNode *update[MAX_LEVEL];
    for (int i = obj->level; i >= 0; i--) {
        while (current->forward[i] != NULL && current->forward[i]->value < num) {
            current = current->forward[i];
        }
        update[i] = current;
    }
    current = current->forward[0];
    if (current == NULL || current->value != num) {
        return false;
    }
    for (int i = 0; i <= obj->level; i++) {
        if (update[i]->forward[i] != current) {
            break;
        }
        update[i]->forward[i] = current->forward[i];
    }
    free(current->forward);
    free(current);
    while (obj->level > 0 && obj->header->forward[obj->level] == NULL) {
        obj->level--;
    }
    return true;
}

void skiplistFree(Skiplist* obj) {
    SkiplistNode *current = obj->header;
    while (current) {
        SkiplistNode *next = current->forward[0];
        free(current->forward);
        free(current);
        current = next;
    }
    free(obj);
}