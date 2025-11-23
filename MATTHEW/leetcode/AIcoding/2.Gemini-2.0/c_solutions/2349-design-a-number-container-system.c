#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *nums;
    int *indices;
    int capacity;
    int size;
} NumberContainer;

NumberContainer* numberContainerCreate() {
    NumberContainer* obj = (NumberContainer*)malloc(sizeof(NumberContainer));
    obj->capacity = 100001;
    obj->size = 0;
    obj->nums = (int*)malloc(obj->capacity * sizeof(int));
    obj->indices = (int*)malloc(obj->capacity * sizeof(int));

    for(int i = 0; i < obj->capacity; i++){
        obj->nums[i] = -1;
        obj->indices[i] = -1;
    }

    return obj;
}

void numberContainerPut(NumberContainer* obj, int index, int number) {
    obj->nums[index] = number;
}

int numberContainerGet(NumberContainer* obj, int index) {
    return obj->nums[index];
}

int numberContainerFind(NumberContainer* obj, int number) {
    int min_index = -1;
    for(int i = 0; i < obj->capacity; i++){
        if(obj->nums[i] == number){
            if(min_index == -1 || i < min_index){
                min_index = i;
            }
        }
    }
    return min_index;
}

void numberContainerFree(NumberContainer* obj) {
    free(obj->nums);
    free(obj->indices);
    free(obj);
}