#include <stdlib.h>
#include <stdbool.h>

int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

typedef struct {
    int a, b, c;
} Triplet;

int compareTriplets(const void* t1_ptr, const void* t2_ptr) {
    Triplet t1 = *(Triplet*)t1_ptr;
    Triplet t2 = *(Triplet*)t2_ptr;

    if (t1.a != t2.a) return t1.a - t2.a;
    if (t1.b != t2.b) return t1.b - t2.b;
    return t1.c - t2.c;
}

int numberOfUniqueXORTriplets(int* nums, int numsSize) {
    if (numsSize < 3) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compareInts);

    Triplet* foundTriplets = (Triplet*)malloc(numsSize * numsSize * sizeof(Triplet));
    if (!foundTriplets) {
        return 0;
    }
    int tripletCount = 0;

    for (int i = 0; i < numsSize - 2; ++i) {
        if (i > 0 && nums[i] == nums[i-1]) {
            continue;
        }

        for (int j = i + 1; j < numsSize - 1; ++j) {
            if (j > i + 1 && nums[j] == nums[j-1]) {
                continue;
            }

            int target_c = nums[i] ^ nums[j];

            int low = j + 1;
            int high = numsSize - 1;
            int k_idx = -1;

            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (nums[mid] == target_c) {
                    k_idx = mid;
                    break;
                }
                if (nums[mid] < target_c) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }

            if (k_idx != -1) {
                foundTriplets[tripletCount++] = (Triplet){nums[i], nums[j], nums[k_idx]};
            }
        }
    }

    qsort(foundTriplets, tripletCount, sizeof(Triplet), compareTriplets);

    int uniqueCount = 0;
    if (tripletCount > 0) {
        uniqueCount = 1;
        for (int i = 1; i < tripletCount; ++i) {
            if (compareTriplets(&foundTriplets[i], &foundTriplets[i-1]) != 0) {
                uniqueCount++;
            }
        }
    }

    free(foundTriplets);
    return uniqueCount;
}