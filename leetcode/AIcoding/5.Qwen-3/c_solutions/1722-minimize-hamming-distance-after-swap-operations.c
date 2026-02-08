#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minHams(int* a, int* b, int n) {
    int* temp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        temp[i] = a[i];
    }
    qsort(temp, n, sizeof(int), compare);
    qsort(b, n, sizeof(int), compare);
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (temp[i] != b[i]) {
            count++;
        }
    }
    free(temp);
    return count;
}

int main() {
    return 0;
}