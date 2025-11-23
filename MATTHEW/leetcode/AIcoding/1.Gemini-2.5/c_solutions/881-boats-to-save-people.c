#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int numRescueBoats(int* people, int peopleSize, int limit) {
    qsort(people, peopleSize, sizeof(int), compare);

    int boats = 0;
    int left = 0;
    int right = peopleSize - 1;

    while (left <= right) {
        boats++;
        if (people[left] + people[right] <= limit) {
            left++;
        }
        right--;
    }

    return boats;
}