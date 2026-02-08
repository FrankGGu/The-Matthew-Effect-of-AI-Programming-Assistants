#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int findMaximizedCapital(int k, int w, int* profits, int profitsSize, int* capital, int capitalSize) {
    int i;
    int* projects = (int*)malloc(profitsSize * sizeof(int));
    for (i = 0; i < profitsSize; i++) {
        projects[i] = profits[i];
    }

    qsort(projects, profitsSize, sizeof(int), compare);

    for (i = 0; i < k; i++) {
        int maxProfit = -1;
        int index = -1;
        for (int j = 0; j < profitsSize; j++) {
            if (capital[j] <= w && projects[j] != -1) {
                if (projects[j] > maxProfit) {
                    maxProfit = projects[j];
                    index = j;
                }
            }
        }
        if (index == -1) break;
        w += maxProfit;
        projects[index] = -1;
    }

    free(projects);
    return w;
}