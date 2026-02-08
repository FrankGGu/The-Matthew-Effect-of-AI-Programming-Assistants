#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char **history;
    int current;
    int size;
    int capacity;
} BrowserHistory;

BrowserHistory* browserHistoryCreate(char *homepage) {
    BrowserHistory *obj = (BrowserHistory*)malloc(sizeof(BrowserHistory));
    obj->capacity = 100;
    obj->history = (char**)malloc(obj->capacity * sizeof(char*));
    obj->history[0] = (char*)malloc((strlen(homepage) + 1) * sizeof(char));
    strcpy(obj->history[0], homepage);
    obj->current = 0;
    obj->size = 1;
    return obj;
}

void browserHistoryVisit(BrowserHistory* obj, char *url) {
    obj->current++;
    if (obj->current == obj->capacity) {
        obj->capacity *= 2;
        obj->history = (char**)realloc(obj->history, obj->capacity * sizeof(char*));
    }
    obj->history[obj->current] = (char*)malloc((strlen(url) + 1) * sizeof(char));
    strcpy(obj->history[obj->current], url);
    obj->size = obj->current + 1;
}

char * browserHistoryBack(BrowserHistory* obj, int steps) {
    obj->current = (obj->current - steps < 0) ? 0 : obj->current - steps;
    return obj->history[obj->current];
}

char * browserHistoryForward(BrowserHistory* obj, int steps) {
    obj->current = (obj->current + steps >= obj->size) ? obj->size - 1 : obj->current + steps;
    return obj->history[obj->current];
}

void browserHistoryFree(BrowserHistory* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->history[i]);
    }
    free(obj->history);
    free(obj);
}