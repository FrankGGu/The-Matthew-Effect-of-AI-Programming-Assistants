#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct MaxHeap {
    int freq;
    char ch;
};

int cmp(const void *a, const void *b) {
    return ((struct MaxHeap *)b)->freq - ((struct MaxHeap *)a)->freq;
}

char *reorganizeString(char *s) {
    int count[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    struct MaxHeap heap[26];
    int heapSize = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            heap[heapSize++] = (struct MaxHeap){count[i], 'a' + i};
        }
    }

    qsort(heap, heapSize, sizeof(struct MaxHeap), cmp);

    char *result = (char *)malloc(len + 1);
    int idx = 0;

    while (heapSize > 0) {
        struct MaxHeap first = heap[0];
        heap[0] = heap[--heapSize];
        int i = 0;
        while (i < first.freq) {
            if (idx >= len) return "";
            result[idx++] = first.ch;
            if (heapSize > 0) {
                struct MaxHeap second = heap[0];
                heap[0] = heap[--heapSize];
                result[idx++] = second.ch;
                if (--second.freq > 0) {
                    heap[heapSize++] = second;
                }
            }
            if (--first.freq > 0) {
                heap[heapSize++] = first;
            }
            qsort(heap, heapSize, sizeof(struct MaxHeap), cmp);
            first = heap[0];
        }
    }

    result[idx] = '\0';
    return idx == len ? result : "";
}