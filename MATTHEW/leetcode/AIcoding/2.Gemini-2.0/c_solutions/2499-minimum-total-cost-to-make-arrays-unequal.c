#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minimumTotalCost(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int mismatch_count = 0;
    int* counts = (int*)calloc(100001, sizeof(int));
    int most_frequent = 0;
    int most_frequent_count = 0;
    long long cost = 0;

    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i] == nums2[i]) {
            mismatch_count++;
            counts[nums1[i]]++;
            cost += i;
            if (counts[nums1[i]] > most_frequent_count) {
                most_frequent_count = counts[nums1[i]];
                most_frequent = nums1[i];
            }
        }
    }

    if (most_frequent_count <= mismatch_count / 2) {
        free(counts);
        return cost;
    }

    int needed = most_frequent_count - mismatch_count / 2;
    for (int i = 0; i < nums1Size && needed > 0; i++) {
        if (nums1[i] != nums2[i] && nums1[i] != most_frequent && nums2[i] != most_frequent) {
            cost += i;
            needed--;
            mismatch_count++;
        }
    }

    free(counts);
    if (needed > 0) {
        return -1;
    }

    return cost;
}