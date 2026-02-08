#include <stdio.h>
#include <stdlib.h>

int* findClosestPeople(int* people, int peopleSize, int target, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    int minDist = -1;
    int closestIndex = -1;

    for (int i = 0; i < peopleSize; i++) {
        int dist = abs(people[i] - target);
        if (minDist == -1 || dist < minDist) {
            minDist = dist;
            closestIndex = i;
        }
    }

    result[0] = people[closestIndex];
    result[1] = closestIndex;
    *returnSize = 2;
    return result;
}