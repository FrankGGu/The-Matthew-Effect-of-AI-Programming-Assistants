#include <string.h>
#include <stdlib.h>

typedef struct {
    char** history;
    int current;
    int size;
} BrowserHistory;

BrowserHistory* browserHistoryCreate(char * homepage) {
    BrowserHistory* browser = (BrowserHistory*)malloc(sizeof(BrowserHistory));
    browser->history = (char**)malloc(5000 * sizeof(char*));
    browser->history[0] = strdup(homepage);
    browser->current = 0;
    browser->size = 1;
    return browser;
}

void browserHistoryVisit(BrowserHistory* obj, char * url) {
    obj->current++;
    obj->history[obj->current] = strdup(url);
    obj->size = obj->current + 1;
}

char* browserHistoryBack(BrowserHistory* obj, int steps) {
    obj->current = obj->current - steps < 0 ? 0 : obj->current - steps;
    return obj->history[obj->current];
}

char* browserHistoryForward(BrowserHistory* obj, int steps) {
    obj->current = obj->current + steps >= obj->size ? obj->size - 1 : obj->current + steps;
    return obj->history[obj->current];
}

void browserHistoryFree(BrowserHistory* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->history[i]);
    }
    free(obj->history);
    free(obj);
}