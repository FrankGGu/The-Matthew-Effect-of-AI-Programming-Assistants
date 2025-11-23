#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int height;
    int type; // 1 for start, -1 for end
} Event;

int compare(const void *a, const void *b) {
    Event *ea = (Event *)a;
    Event *eb = (Event *)b;
    if (ea->x != eb->x) {
        return ea->x - eb->x;
    } else {
        if (ea->type != eb->type) {
            return eb->type - ea->type;
        } else {
            if (ea->type == 1) {
                return eb->height - ea->height;
            } else {
                return ea->height - eb->height;
            }
        }
    }
}

int** getSkyline(int** buildings, int buildingsSize, int* buildingsColSize, int* returnSize, int** returnColumnSizes) {
    int eventCount = 2 * buildingsSize;
    Event* events = (Event*)malloc(eventCount * sizeof(Event));
    for (int i = 0; i < buildingsSize; i++) {
        events[2 * i].x = buildings[i][0];
        events[2 * i].height = buildings[i][2];
        events[2 * i].type = 1;
        events[2 * i + 1].x = buildings[i][1];
        events[2 * i + 1].height = buildings[i][2];
        events[2 * i + 1].type = -1;
    }

    qsort(events, eventCount, sizeof(Event), compare);

    int* heightHeap = (int*)malloc((buildingsSize + 1) * sizeof(int));
    int heapSize = 0;
    heightHeap[heapSize++] = 0;

    int** result = (int**)malloc(eventCount * sizeof(int*));
    *returnColumnSizes = (int*)malloc(eventCount * sizeof(int));
    *returnSize = 0;

    int prevHeight = 0;
    for (int i = 0; i < eventCount; i++) {
        Event event = events[i];
        if (event.type == 1) {
            int j = heapSize++;
            while (j > 0 && heightHeap[(j - 1) / 2] < event.height) {
                heightHeap[j] = heightHeap[(j - 1) / 2];
                j = (j - 1) / 2;
            }
            heightHeap[j] = event.height;
        } else {
            for (int j = 0; j < heapSize; j++) {
                if (heightHeap[j] == event.height) {
                    heightHeap[j] = heightHeap[--heapSize];
                    int k = j;
                    while (1) {
                        int left = 2 * k + 1;
                        int right = 2 * k + 2;
                        int largest = k;
                        if (left < heapSize && heightHeap[left] > heightHeap[largest]) {
                            largest = left;
                        }
                        if (right < heapSize && heightHeap[right] > heightHeap[largest]) {
                            largest = right;
                        }
                        if (largest != k) {
                            int temp = heightHeap[k];
                            heightHeap[k] = heightHeap[largest];
                            heightHeap[largest] = temp;
                            k = largest;
                        } else {
                            break;
                        }
                    }
                    break;
                }
            }
        }

        int currentHeight = heightHeap[0];
        if (currentHeight != prevHeight) {
            result[*returnSize] = (int*)malloc(2 * sizeof(int));
            result[*returnSize][0] = event.x;
            result[*returnSize][1] = currentHeight;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
            prevHeight = currentHeight;
        }
    }

    free(events);
    free(heightHeap);

    return result;
}