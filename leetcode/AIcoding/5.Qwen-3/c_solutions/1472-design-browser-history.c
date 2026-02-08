#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* url;
    struct BrowserHistory* prev;
    struct BrowserHistory* next;
} BrowserHistory;

BrowserHistory* browserHistoryCreate(char* homepage) {
    BrowserHistory* node = (BrowserHistory*)malloc(sizeof(BrowserHistory));
    node->url = strdup(homepage);
    node->prev = NULL;
    node->next = NULL;
    return node;
}

void browserHistoryVisit(BrowserHistory* obj, char* url) {
    BrowserHistory* new_node = (BrowserHistory*)malloc(sizeof(BrowserHistory));
    new_node->url = strdup(url);
    new_node->prev = obj;
    new_node->next = NULL;
    obj->next = new_node;
}

char* browserHistoryBack(BrowserHistory* obj, int steps) {
    while (obj->prev && steps > 0) {
        obj = obj->prev;
        steps--;
    }
    return obj->url;
}

char* browserHistoryForward(BrowserHistory* obj, int steps) {
    while (obj->next && steps > 0) {
        obj = obj->next;
        steps--;
    }
    return obj->url;
}

void browserHistoryFree(BrowserHistory* obj) {
    BrowserHistory* current = obj;
    while (current) {
        BrowserHistory* next = current->next;
        free(current->url);
        free(current);
        current = next;
    }
}