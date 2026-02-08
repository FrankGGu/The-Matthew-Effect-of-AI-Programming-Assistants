#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

#define MAX_LEVEL 16

typedef struct SkiplistNode {
    int val;
    struct SkiplistNode* next[MAX_LEVEL];
} SkiplistNode;

typedef struct {
    SkiplistNode* head;
    int level;
} Skiplist;

static int randomLevel() {
    int lvl = 1;
    while ((rand() & 1) && lvl < MAX_LEVEL) {
        lvl++;
    }
    return lvl;
}

Skiplist* skiplistCreate() {
    static bool seeded = false;
    if (!seeded) {
        srand(time(NULL));
        seeded = true;
    }

    Skiplist* obj = (Skiplist*)malloc(sizeof(Skiplist));
    obj->head = (SkiplistNode*)malloc(sizeof(SkiplistNode));
    obj->head->val = -1; 

    for (int i = 0; i < MAX_LEVEL; i++) {
        obj->head->next[i] = NULL;
    }
    obj->level = 0;

    return obj;
}

bool skiplistSearch(Skiplist* obj, int target) {
    SkiplistNode* curr = obj->head;

    for (int i = obj->level - 1; i >= 0; i--) {
        while (curr->next[i] != NULL && curr->next[i]->val < target) {
            curr = curr->next[i];
        }
    }

    curr = curr->next[0];

    return curr != NULL && curr->val == target;
}

void skiplistAdd(Skiplist* obj, int num) {
    SkiplistNode* update[MAX_LEVEL];
    SkiplistNode* curr = obj->head;

    for (int i = obj->level - 1; i >= 0; i--) {
        while (curr->next[i] != NULL && curr->next[i]->val < num) {
            curr = curr->next[i];
        }
        update[i] = curr;
    }

    int newLevel = randomLevel();

    if (newLevel > obj->level) {
        for (int i = obj->level; i < newLevel; i++) {
            update[i] = obj->head;
        }
        obj->level = newLevel;
    }

    SkiplistNode* newNode = (SkiplistNode*)malloc(sizeof(SkiplistNode));
    newNode->val = num;

    for (int i = 0; i < newLevel; i++) {
        newNode->next[i] = update[i]->next[i];
        update[i]->next[i] = newNode;
    }
}

bool skiplistErase(Skiplist* obj, int num) {
    SkiplistNode* update[MAX_LEVEL];
    SkiplistNode* curr = obj->head;

    for (int i = obj->level - 1; i >= 0; i--) {
        while (curr->next[i] != NULL && curr->next[i]->val < num) {
            curr = curr->next[i];
        }
        update[i] = curr;
    }

    curr = curr->next[0];

    if (curr == NULL || curr->val != num) {
        return false;
    }

    for (int i = 0; i < obj->level; i++) {
        if (update[i]->next[i] == curr) {
            update[i]->next[i] = curr->next[i];
        }
    }

    free(curr);

    while (obj->level > 1 && obj->head->next[obj->level - 1] == NULL) {
        obj->level--;
    }

    return true;
}

void skiplistFree(Skiplist* obj) {
    SkiplistNode* curr = obj->head->next[0];
    SkiplistNode* temp;

    while (curr != NULL) {
        temp = curr;
        curr = curr->next[0];
        free(temp);
    }

    free(obj->head);
    free(obj);
}