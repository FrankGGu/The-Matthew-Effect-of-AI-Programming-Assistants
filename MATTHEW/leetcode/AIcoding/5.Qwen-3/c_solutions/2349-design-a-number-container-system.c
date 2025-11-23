#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* index;
    int size;
} NumberContainer;

NumberContainer* numberContainerCreate() {
    NumberContainer* obj = (NumberContainer*)malloc(sizeof(NumberContainer));
    obj->index = NULL;
    obj->size = 0;
    return obj;
}

void numberContainerChange(NumberContainer* obj, int index, int number) {
    int* new_index = (int*)realloc(obj->index, (obj->size + 1) * sizeof(int));
    if (new_index == NULL) {
        return;
    }
    obj->index = new_index;
    obj->index[obj->size++] = number;
}

int numberContainerRetrieve(NumberContainer* obj, int index) {
    if (index < 0 || index >= obj->size) {
        return -1;
    }
    return obj->index[index];
}

void numberContainerFree(NumberContainer* obj) {
    free(obj->index);
    free(obj);
}