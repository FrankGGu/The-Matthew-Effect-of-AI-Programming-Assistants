#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximumGroups(int* grades, int gradesSize){
    qsort(grades, gradesSize, sizeof(int), cmp);

    int groups = 0;
    int current_size = 0;
    int current_sum = 0;
    int index = 0;

    while (index < gradesSize) {
        if (gradesSize - index >= current_size + 1) {
            current_size++;
            for (int i = 0; i < current_size; i++) {
                current_sum += grades[index + i];
            }
            index += current_size;
            groups++;
        } else {
            break;
        }
    }

    return groups;
}