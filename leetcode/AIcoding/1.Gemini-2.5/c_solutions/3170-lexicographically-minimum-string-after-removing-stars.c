#include <stdlib.h>
#include <string.h>

typedef struct {
    int neg_char_val;
    int neg_original_idx;
} HeapNode;

typedef struct {
    HeapNode* nodes;
    int capacity;
    int size;
} MinHeap;

void heap_init(MinHeap* heap, int capacity) {
    heap->nodes = (HeapNode*)malloc(sizeof(HeapNode) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
}

void heap_free(MinHeap* heap) {
    free(heap->nodes);
    heap->nodes = NULL;
    heap->capacity = 0;
    heap->size = 0;
}

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heap_swim(MinHeap* heap, int k) {
    while (k > 0 && (heap->nodes[k].neg_char_val < heap->nodes[(k - 1) / 2].neg_char_val ||
                     (heap->nodes[k].neg_char_val == heap->nodes[(k - 1) / 2].neg_char_val &&
                      heap->nodes[k].neg_original_idx < heap->nodes[(k - 1) / 2].neg_original_idx))) {
        swap(&heap->nodes[k], &heap->nodes[(k - 1) / 2]);
        k = (k - 1) / 2;
    }
}

void heap_sink(MinHeap* heap, int k) {
    while (2 * k + 1 < heap->size) {
        int j = 2 * k + 1;
        if (j + 1 < heap->size && (heap->nodes[j + 1].neg_char_val < heap->nodes[j].neg_char_val ||
                                   (heap->nodes[j + 1].neg_char_val == heap->nodes[j].neg_char_val &&
                                    heap->nodes[j + 1].neg_original_idx < heap->nodes[j].neg_original_idx))) {
            j++;
        }
        if (heap->nodes[k].neg_char_val < heap->nodes[j].neg_char_val ||
            (heap->nodes[k].neg_char_val == heap->nodes[j].neg_char_val &&
             heap->nodes[k].neg_original_idx < heap->nodes[j].neg_original_idx)) {
            break;
        }
        swap(&heap->nodes[k], &heap->nodes[j]);
        k = j;
    }
}

void heap_push(MinHeap* heap, HeapNode node) {
    if (heap->size == heap->capacity) {
        return;
    }
    heap->nodes[heap->size] = node;
    heap->size++;
    heap_swim(heap, heap->size - 1);
}

HeapNode heap_pop(MinHeap* heap) {
    HeapNode min_node = heap->nodes[0];
    heap->size--;
    if (heap->size > 0) {
        heap->nodes[0] = heap->nodes[heap->size];
        heap_sink(heap, 0);
    }
    return min_node;
}

typedef struct {
    char ch;
    int original_idx;
} RemainingChar;

int compareRemainingChars(const void* a, const void* b) {
    return ((RemainingChar*)a)->original_idx - ((RemainingChar*)b)->original_idx;
}

char* removeStars(char* s) {
    int n = strlen(s);
    MinHeap heap;
    heap_init(&heap, n);

    for (int i = 0; i < n; i++) {
        if (s[i] == '*') {
            heap_pop(&heap);
        } else {
            HeapNode node = {-(int)s[i], -i};
            heap_push(&heap, node);
        }
    }

    RemainingChar* remaining_chars = (RemainingChar*)malloc(sizeof(RemainingChar) * heap.size);
    int count = 0;
    while (heap.size > 0) {
        HeapNode node = heap_pop(&heap);
        remaining_chars[count].ch = (char)(-node.neg_char_val);
        remaining_chars[count].original_idx = (int)(-node.neg_original_idx);
        count++;
    }

    qsort(remaining_chars, count, sizeof(RemainingChar), compareRemainingChars);

    char* result = (char*)malloc(sizeof(char) * (count + 1));
    for (int i = 0; i < count; i++) {
        result[i] = remaining_chars[i].ch;
    }
    result[count] = '\0';

    free(remaining_chars);
    heap_free(&heap);

    return result;
}