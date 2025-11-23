#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Event;

typedef struct {
    int start;
    int end;
    int count;
} Node;

typedef struct {
    Node* nodes;
    int size;
    int capacity;
} MyCalendarThree;

MyCalendarThree* myCalendarThreeCreate() {
    MyCalendarThree* obj = (MyCalendarThree*)malloc(sizeof(MyCalendarThree));
    obj->nodes = (Node*)malloc(10000 * sizeof(Node));
    obj->size = 0;
    obj->capacity = 10000;
    return obj;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int myCalendarThreeBook(MyCalendarThree* obj, int start, int end) {
    int max_k = 0;

    for (int i = 0; i < obj->size; i++) {
        if (start < obj->nodes[i].end && end > obj->nodes[i].start) {
            obj->nodes[i].count++;
        }
        max_k = max(max_k, obj->nodes[i].count);
    }

    Node new_node = {start, end, 1};
    obj->nodes[obj->size++] = new_node;

    if (obj->size >= obj->capacity) {
        obj->capacity *= 2;
        obj->nodes = (Node*)realloc(obj->nodes, obj->capacity * sizeof(Node));
    }

    max_k = 0;
    for(int i=0; i< obj->size; i++){
        max_k = max(max_k, obj->nodes[i].count);
    }

    int global_max = 0;
    int temp_start = 0;
    int temp_end = 0;

    for(int i = 0; i < obj->size; i++){
        temp_start = obj->nodes[i].start;
        temp_end = obj->nodes[i].end;
        int current_count = 0;
        for(int j = 0; j < obj->size; j++){
            if (temp_start < obj->nodes[j].end && temp_end > obj->nodes[j].start){
                current_count += obj->nodes[j].count;
            }
        }

        global_max = max(global_max, current_count);
    }

    return global_max;
}

void myCalendarThreeFree(MyCalendarThree* obj) {
    free(obj->nodes);
    free(obj);
}