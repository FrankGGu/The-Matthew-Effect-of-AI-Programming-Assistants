#include <stdlib.h>
#include <string.h>

int compare(const void* a, const void* b) {
    int* courseA = *(int**)a;
    int* courseB = *(int**)b;
    return courseA[1] - courseB[1];
}

int scheduleCourse(int** courses, int coursesSize, int* coursesColSize) {
    qsort(courses, coursesSize, sizeof(int*), compare);

    int* heap = (int*)malloc(coursesSize * sizeof(int));
    int heapSize = 0;
    int totalTime = 0;

    for (int i = 0; i < coursesSize; i++) {
        int duration = courses[i][0];
        int lastDay = courses[i][1];

        if (totalTime + duration <= lastDay) {
            heap[heapSize++] = duration;
            totalTime += duration;

            for (int j = heapSize - 1; j > 0 && heap[j] > heap[(j - 1) / 2]; j = (j - 1) / 2) {
                int temp = heap[j];
                heap[j] = heap[(j - 1) / 2];
                heap[(j - 1) / 2] = temp;
            }
        } else if (heapSize > 0 && duration < heap[0]) {
            totalTime += duration - heap[0];
            heap[0] = duration;

            int j = 0;
            while (2 * j + 1 < heapSize) {
                int left = 2 * j + 1;
                int right = 2 * j + 2;
                int largest = j;

                if (left < heapSize && heap[left] > heap[largest]) {
                    largest = left;
                }
                if (right < heapSize && heap[right] > heap[largest]) {
                    largest = right;
                }

                if (largest != j) {
                    int temp = heap[j];
                    heap[j] = heap[largest];
                    heap[largest] = temp;
                    j = largest;
                } else {
                    break;
                }
            }
        }
    }

    free(heap);
    return heapSize;
}