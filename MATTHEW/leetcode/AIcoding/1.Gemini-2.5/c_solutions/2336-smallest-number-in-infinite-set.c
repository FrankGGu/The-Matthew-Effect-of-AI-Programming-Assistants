#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define MAX_NUM_VAL 1001 // Numbers are between 1 and 1000, so array size 1001 for indices 0-1000
#define HEAP_CAPACITY MAX_NUM_VAL

typedef struct {
    int* heap_arr;
    int heap_size;
    int next_smallest;
    bool is_present[MAX_NUM_VAL];
} SmallestInfiniteSet;

static void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

static void heapify_up(SmallestInfiniteSet* obj, int index) {
    int parent_idx = (index - 1) / 2;
    while (index > 0 && obj->heap_arr[index] < obj->heap_arr[parent_idx]) {
        swap(&obj->heap_arr[index], &obj->heap_arr[parent_idx]);
        index = parent_idx;
        parent_idx = (index - 1) / 2;
    }
}

static void heapify_down(SmallestInfiniteSet* obj, int index) {
    int smallest = index;
    int left_child = 2 * index + 1;
    int right_child = 2 * index + 2;

    if (left_child < obj->heap_size && obj->heap_arr[left_child] < obj->heap_arr[smallest]) {
        smallest = left_child;
    }
    if (right_child < obj->heap_size && obj->heap_arr[right_child] < obj->heap_arr[smallest]) {
        smallest = right_child;
    }

    if (smallest != index) {
        swap(&obj->heap_arr[index], &obj->heap_arr[smallest]);
        heapify_down(obj, smallest);
    }
}

static void heap_push(SmallestInfiniteSet* obj, int val) {
    if (obj->heap_size >= HEAP_CAPACITY) {
        return;
    }
    obj->heap_arr[obj->heap_size] = val;
    obj->heap_size++;
    heapify_up(obj, obj->heap_size - 1);
}

static int heap_pop(SmallestInfiniteSet* obj) {
    if (obj->heap_size == 0) {
        return -1;
    }
    int root = obj->heap_arr[0];
    obj->heap_arr[0] = obj->heap_arr[obj->heap_size - 1];
    obj->heap_size--;
    heapify_down(obj, 0);
    return root;
}

SmallestInfiniteSet* smallestInfiniteSetCreate() {
    SmallestInfiniteSet* obj = (SmallestInfiniteSet*)malloc(sizeof(SmallestInfiniteSet));
    obj->heap_arr = (int*)malloc(sizeof(int) * HEAP_CAPACITY);
    obj->heap_size = 0;
    obj->next_smallest = 1;
    memset(obj->is_present, 0, sizeof(bool) * MAX_NUM_VAL);
    return obj;
}

int smallestInfiniteSetPopSmallest(SmallestInfiniteSet* obj) {
    if (obj->heap_size > 0 && obj->heap_arr[0] < obj->next_smallest) {
        int val = heap_pop(obj);
        obj->is_present[val] = false;
        return val;
    } else {
        int val = obj->next_smallest;
        obj->next_smallest++;
        return val;
    }
}

void smallestInfiniteSetAddBack(SmallestInfiniteSet* obj, int num) {
    if (num < obj->next_smallest && !obj->is_present[num]) {
        heap_push(obj, num);
        obj->is_present[num] = true;
    }
}

void smallestInfiniteSetFree(SmallestInfiniteSet* obj) {
    free(obj->heap_arr);
    free(obj);
}