#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int speed;
    int efficiency;
} Employee;

int compare(const void *a, const void *b) {
    Employee *e1 = (Employee *)a;
    Employee *e2 = (Employee *)b;
    return e2->efficiency - e1->efficiency;
}

long long maxPerformance(int n, int** candidates, int candidatesSize, int* candidatesColSize, int k) {
    Employee *employees = (Employee *)malloc(n * sizeof(Employee));
    for (int i = 0; i < n; i++) {
        employees[i].speed = candidates[i][0];
        employees[i].efficiency = candidates[i][1];
    }

    qsort(employees, n, sizeof(Employee), compare);

    long long result = 0;
    long long totalSpeed = 0;
    int *heap = (int *)malloc(k * sizeof(int));
    int heapSize = 0;

    for (int i = 0; i < n; i++) {
        int speed = employees[i].speed;
        int efficiency = employees[i].efficiency;

        if (heapSize < k) {
            heap[heapSize++] = speed;
            totalSpeed += speed;
        } else {
            if (speed > heap[0]) {
                totalSpeed -= heap[0];
                heap[0] = speed;
                for (int j = 0; j < heapSize; j++) {
                    for (int m = j + 1; m < heapSize; m++) {
                        if (heap[j] > heap[m]) {
                            int temp = heap[j];
                            heap[j] = heap[m];
                            heap[m] = temp;
                        }
                    }
                }
                totalSpeed += heap[0];
            }
        }

        result = (result > totalSpeed * efficiency) ? result : totalSpeed * efficiency;
    }

    free(employees);
    free(heap);
    return result;
}