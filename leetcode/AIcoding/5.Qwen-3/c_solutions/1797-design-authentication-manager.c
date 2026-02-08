#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int time;
} Item;

typedef struct {
    Item** items;
    int size;
    int capacity;
} AuthManager;

AuthManager* authManagerCreate(int timeToLive) {
    AuthManager* obj = (AuthManager*)malloc(sizeof(AuthManager));
    obj->items = (Item**)malloc(100 * sizeof(Item*));
    obj->size = 0;
    obj->capacity = 100;
    return obj;
}

void authManagerGenerate(AuthManager* obj, char* name, int tokenId) {
    for (int i = 0; i < obj->size; i++) {
        if (strcmp(obj->items[i]->name, name) == 0) {
            obj->items[i]->time = tokenId;
            return;
        }
    }
    if (obj->size >= obj->capacity) {
        obj->capacity *= 2;
        obj->items = (Item**)realloc(obj->items, obj->capacity * sizeof(Item*));
    }
    Item* item = (Item*)malloc(sizeof(Item));
    item->name = strdup(name);
    item->time = tokenId;
    obj->items[obj->size++] = item;
}

void authManagerRenew(AuthManager* obj, char* name, int tokenId) {
    for (int i = 0; i < obj->size; i++) {
        if (strcmp(obj->items[i]->name, name) == 0) {
            obj->items[i]->time = tokenId;
            return;
        }
    }
}

void authManagerDrop(AuthManager* obj, char* name) {
    for (int i = 0; i < obj->size; i++) {
        if (strcmp(obj->items[i]->name, name) == 0) {
            free(obj->items[i]->name);
            free(obj->items[i]);
            for (int j = i; j < obj->size - 1; j++) {
                obj->items[j] = obj->items[j + 1];
            }
            obj->size--;
            return;
        }
    }
}

int authManagerGetTimeLeft(AuthManager* obj, char* name) {
    for (int i = 0; i < obj->size; i++) {
        if (strcmp(obj->items[i]->name, name) == 0) {
            return obj->items[i]->time;
        }
    }
    return 0;
}

void authManagerFree(AuthManager* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->items[i]->name);
        free(obj->items[i]);
    }
    free(obj->items);
    free(obj);
}