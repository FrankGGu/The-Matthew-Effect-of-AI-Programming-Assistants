#include <stdlib.h>
#include <string.h>

typedef struct {
    int coord;
    int type; // 0 for interval start, 1 for query
    int val1; // For interval start: interval end point. For query: original query index.
    int val2; // For interval start: interval length.
} Event;

typedef struct {
    int length;
    int end;
} IntervalPQNode;

typedef struct {
    IntervalPQNode* arr;
    int capacity;
    int size;
} MinHeap;

void heap_init(MinHeap* heap, int capacity) {
    heap->arr = (IntervalPQNode*)malloc(sizeof(IntervalPQNode) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
}

void heap_free(MinHeap* heap) {
    free(heap->arr);
}

void heap_swap(IntervalPQNode* a, IntervalPQNode* b) {
    IntervalPQNode temp = *a;
    *a = *b;
    *b = temp;
}

void heap_bubble_up(MinHeap* heap, int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && heap->arr[idx].length < heap->arr[parent].length) {
        heap_swap(&heap->arr[idx], &heap->arr[parent]);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void heap_bubble_down(MinHeap* heap, int idx) {
    int left_child = 2 * idx + 1;
    int right_child = 2 * idx + 2;
    int smallest = idx;

    if (left_child < heap->size && heap->arr[left_child].length < heap->arr[smallest].length) {
        smallest = left_child;
    }
    if (right_child < heap->size && heap->arr[right_child].length < heap->arr[smallest].length) {
        smallest = right_child;
    }

    if (smallest != idx) {
        heap_swap(&heap->arr[idx], &heap->arr[smallest]);
        heap_bubble_down(heap, smallest);
    }
}

void heap_push(MinHeap* heap, IntervalPQNode node) {
    if (heap->size == heap->capacity) {
        return;
    }
    heap->arr[heap->size] = node;
    heap_bubble_up(heap, heap->size);
    heap->size++;
}

IntervalPQNode heap_pop(MinHeap* heap) {
    IntervalPQNode root = heap->arr[0];
    heap->arr[0] = heap->arr[heap->size - 1];
    heap->size--;
    heap_bubble_down(heap, 0);
    return root;
}

IntervalPQNode heap_peek(MinHeap* heap) {
    return heap->arr[0];
}

int heap_is_empty(MinHeap* heap) {
    return heap->size == 0;
}

int compareEvents(const void* a, const void* b) {
    Event* eventA = (Event*)a;
    Event* eventB = (Event*)b;

    if (eventA->coord != eventB->coord) {
        return eventA->coord - eventB->coord;
    }
    return eventA->type - eventB->type;
}

int* minInterval(int** intervals, int intervalsSize, int* intervalsColSize, int* queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int totalEvents = intervalsSize + queriesSize;
    Event* events = (Event*)malloc(sizeof(Event) * totalEvents);

    for (int i = 0; i < intervalsSize; ++i) {
        events[i].coord = intervals[i][0];
        events[i].type = 0;
        events[i].val1 = intervals[i][1];
        events[i].val2 = intervals[i][1] - intervals[i][0] + 1;
    }
    for (int i = 0; i < queriesSize; ++i) {
        events[intervalsSize + i].coord = queries[i];
        events[intervalsSize + i].type = 1;
        events[intervalsSize + i].val1 = i;
        events[intervalsSize + i].val2 = 0;
    }

    qsort(events, totalEvents, sizeof(Event), compareEvents);

    int* results = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;
    for (int i = 0; i < queriesSize; ++i) {
        results[i] = -1;
    }

    MinHeap active_intervals_pq;
    heap_init(&active_intervals_pq, intervalsSize);

    for (int i = 0; i < totalEvents; ++i) {
        Event current_event = events[i];

        if (current_event.type == 0) {
            IntervalPQNode node = { .length = current_event.val2, .end = current_event.val1 };
            heap_push(&active_intervals_pq, node);
        } else {
            int query_point = current_event.coord;
            int original_query_index = current_event.val1;

            while (!heap_is_empty(&active_intervals_pq) && heap_peek(&active_intervals_pq).end < query_point) {
                heap_pop(&active_intervals_pq);
            }

            if (!heap_is_empty(&active_intervals_pq)) {
                results[original_query_index] = heap_peek(&active_intervals_pq).length;
            }
        }
    }

    free(events);
    heap_free(&active_intervals_pq);

    return results;
}