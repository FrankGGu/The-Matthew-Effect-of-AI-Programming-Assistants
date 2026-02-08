#include <stdlib.h>
#include <string.h>

#define MAX_HISTORY_SIZE 5001

typedef struct {
    char* history[MAX_HISTORY_SIZE];
    int current;
    int last;
} BrowserHistory;

BrowserHistory* browserHistoryCreate(char* homepage) {
    BrowserHistory* obj = (BrowserHistory*)malloc(sizeof(BrowserHistory));
    obj->history[0] = (char*)malloc(sizeof(char) * (strlen(homepage) + 1));
    strcpy(obj->history[0], homepage);
    obj->current = 0;
    obj->last = 0;
    return obj;
}

void browserHistoryVisit(BrowserHistory* obj, char* url) {
    obj->current++;
    if (obj->history[obj->current] != NULL) {
        free(obj->history[obj->current]);
    }
    obj->history[obj->current] = (char*)malloc(sizeof(char) * (strlen(url) + 1));
    strcpy(obj->history[obj->current], url);
    obj->last = obj->current;
}

char* browserHistoryBack(BrowserHistory* obj, int steps) {
    obj->current = (obj->current - steps < 0) ? 0 : (obj->current - steps);
    return obj->history[obj->current];
}

char* browserHistoryForward(BrowserHistory* obj, int steps) {
    obj->current = (obj->current + steps > obj->last) ? obj->last : (obj->current + steps);
    return obj->history[obj->current];
}

void browserHistoryFree(BrowserHistory* obj) {
    for (int i = 0; i <= obj->last; i++) {
        if (obj->history[i] != NULL) {
            free(obj->history[i]);
        }
    }
    free(obj);
}