#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int numFriendsAge(int* ages, int agesSize) {
    qsort(ages, agesSize, sizeof(int), compare);
    int count = 0;
    for (int i = 0; i < agesSize; i++) {
        int a = ages[i];
        if (a < 15) continue;
        int left = i;
        int right = agesSize - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (ages[mid] > a / 2 + 7) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        count += agesSize - left;
    }
    return count;
}