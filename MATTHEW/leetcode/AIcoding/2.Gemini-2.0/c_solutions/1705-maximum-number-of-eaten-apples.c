#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int day;
    int count;
} Apple;

int cmp(const void *a, const void *b) {
    return ((Apple*)a)->day - ((Apple*)b)->day;
}

int eatenApples(int* apples, int applesSize, int* days, int daysSize) {
    int eaten = 0;
    Apple heap[applesSize + daysSize];
    int heapSize = 0;
    int day = 0;

    while (day < applesSize || heapSize > 0) {
        if (day < applesSize && apples[day] > 0) {
            heap[heapSize].day = day + days[day];
            heap[heapSize].count = apples[day];
            heapSize++;
            int i = heapSize - 1;
            while (i > 0 && heap[i].day < heap[i - 1].day) {
                Apple temp = heap[i];
                heap[i] = heap[i - 1];
                heap[i - 1] = temp;
                i--;
            }
        }

        while (heapSize > 0 && heap[0].day <= day) {
            for (int i = 0; i < heapSize - 1; i++) {
                heap[i] = heap[i + 1];
            }
            heapSize--;
        }

        if (heapSize > 0) {
            heap[0].count--;
            eaten++;
            if (heap[0].count == 0) {
                for (int i = 0; i < heapSize - 1; i++) {
                    heap[i] = heap[i + 1];
                }
                heapSize--;
            }
            int i = 0;
            while (2 * i + 1 < heapSize) {
                int j = 2 * i + 1;
                if (2 * i + 2 < heapSize && heap[2 * i + 2].day < heap[j].day) {
                    j = 2 * i + 2;
                }
                if (heap[i].day > heap[j].day) {
                    Apple temp = heap[i];
                    heap[i] = heap[j];
                    heap[j] = temp;
                    i = j;
                } else {
                    break;
                }
            }
        }

        day++;
    }

    return eaten;
}