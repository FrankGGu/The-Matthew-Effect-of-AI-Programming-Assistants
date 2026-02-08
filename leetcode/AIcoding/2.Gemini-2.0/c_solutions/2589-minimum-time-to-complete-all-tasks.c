#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
    int duration;
} Task;

int compareTasks(const void *a, const void *b) {
    return ((Task*)a)->end - ((Task*)b)->end;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int minAvailableDuration(int** slots1, int slots1Size, int* slots1ColSize, int** slots2, int slots2Size, int* slots2ColSize, int duration, int** returnSize) {
    int i = 0, j = 0;
    *returnSize = 0;
    int* result = (int*)malloc(2 * sizeof(int));

    while (i < slots1Size && j < slots2Size) {
        int start = max(slots1[i][0], slots2[j][0]);
        int end = min(slots1[i][1], slots2[j][1]);

        if (end - start >= duration) {
            result[0] = start;
            result[1] = start + duration;
            *returnSize = 2;
            return result;
        } else if (slots1[i][1] < slots2[j][1]) {
            i++;
        } else {
            j++;
        }
    }

    free(result);
    return NULL;
}

int cmp(const void *a, const void *b) {
    return (*(int**)a)[0] - (*(int**)b)[0];
}

int cmp2(const void *a, const void *b) {
    return (*(int*)a) - (*(int*)b);
}

int cmp3(const void *a, const void *b) {
    return ((Task*)a)->end - ((Task*)b)->end;
}

int minInterval(int** intervals, int intervalsSize, int* intervalsColSize, int* queries, int queriesSize, int* returnSize) {
    *returnSize = queriesSize;
    int* ans = (int*)malloc(queriesSize * sizeof(int));
    int** q = (int**)malloc(queriesSize * sizeof(int*));
    for(int i = 0; i < queriesSize; i++) {
        q[i] = (int*)malloc(2 * sizeof(int));
        q[i][0] = queries[i];
        q[i][1] = i;
    }

    qsort(q, queriesSize, sizeof(int*), cmp);
    qsort(intervals, intervalsSize, sizeof(int*), cmp);

    int j = 0;
    int heap_size = 0;
    int* heap = (int*)malloc(100001 * sizeof(int)); // Adjusted size

    for(int i = 0; i < queriesSize; i++) {
        int query = q[i][0];
        int index = q[i][1];

        while(j < intervalsSize && intervals[j][0] <= query) {
            int interval_size = intervals[j][1] - intervals[j][0] + 1;

            int k = heap_size;
            heap[heap_size++] = interval_size;

            while(k > 0 && heap[k] < heap[(k-1)/2]) {
                int temp = heap[k];
                heap[k] = heap[(k-1)/2];
                heap[(k-1)/2] = temp;
                k = (k-1)/2;
            }
            j++;
        }

        while(heap_size > 0 && intervals[j-1][1] < query) {

            int temp = heap[0];
            heap[0] = heap[--heap_size];
            heap[heap_size] = temp;

            int k = 0;
            while(2*k+1 < heap_size) {
                int child = 2*k+1;
                if(2*k+2 < heap_size && heap[2*k+2] < heap[2*k+1]) {
                    child = 2*k+2;
                }
                if(heap[k] > heap[child]) {
                    temp = heap[k];
                    heap[k] = heap[child];
                    heap[child] = temp;
                    k = child;
                } else {
                    break;
                }
            }
        }

        if(heap_size == 0) {
            ans[index] = -1;
        } else {
            ans[index] = heap[0];
        }
    }

    for(int i = 0; i < queriesSize; i++) {
        free(q[i]);
    }
    free(q);
    free(heap);

    return ans;
}

int minInterval2(int** intervals, int intervalsSize, int* intervalsColSize, int* queries, int queriesSize, int* returnSize) {
    *returnSize = queriesSize;
    int* ans = (int*)malloc(queriesSize * sizeof(int));
    int** q = (int**)malloc(queriesSize * sizeof(int*));
    for(int i = 0; i < queriesSize; i++) {
        q[i] = (int*)malloc(2 * sizeof(int));
        q[i][0] = queries[i];
        q[i][1] = i;
    }

    qsort(q, queriesSize, sizeof(int*), cmp);
    qsort(intervals, intervalsSize, sizeof(int*), cmp);

    int j = 0;
    int heap_size = 0;
    int* heap = (int*)malloc(intervalsSize * sizeof(int)); // Adjusted size
    int* heap_val = (int*)malloc(intervalsSize * sizeof(int)); // Store interval sizes

    for(int i = 0; i < queriesSize; i++) {
        int query = q[i][0];
        int index = q[i][1];

        // Add intervals that start before the query
        while(j < intervalsSize && intervals[j][0] <= query) {
            int interval_size = intervals[j][1] - intervals[j][0] + 1;

            // Insert into min-heap
            int k = heap_size;
            heap[heap_size] = j;
            heap_val[heap_size] = interval_size;
            heap_size++;

            while(k > 0 && heap_val[heap[k]] < heap_val[heap[heap[(k-1)/2]]]) {
                int temp = heap[k];
                heap[k] = heap[heap[(k-1)/2]];
                heap[heap[(k-1)/2]] = temp;
                k = (k-1)/2;
            }
            j++;
        }

        // Remove intervals that end before the query
        int k = 0;
        while(k < heap_size) {
          if(intervals[heap[k]][1] < query) {

            heap[k] = heap[heap_size - 1];
            heap_size--;
            if(k < heap_size){
            int l = k;
            while(2*l+1 < heap_size) {
                int child = 2*l+1;
                if(2*l+2 < heap_size && heap_val[heap[2*l+2]] < heap_val[heap[2*l+1]]) {
                    child = 2*l+2;
                }
                if(heap_val[heap[l]] > heap_val[heap[child]]) {
                    int temp = heap[l];
                    heap[l] = heap[child];
                    heap[child] = temp;
                    l = child;
                } else {
                    break;
                }
            }
           }
          } else {
            k++;
          }
        }

        if(heap_size == 0) {
            ans[index] = -1;
        } else {
            ans[index] = heap_val[heap[0]];
        }
    }

    for(int i = 0; i < queriesSize; i++) {
        free(q[