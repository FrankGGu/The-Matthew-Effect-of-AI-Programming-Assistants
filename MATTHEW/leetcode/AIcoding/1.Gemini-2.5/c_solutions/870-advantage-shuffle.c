#include <stdlib.h>

typedef struct {
    int val;
    int original_idx;
} Pair;

int compareInt(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int comparePair(const void *a, const void *b) {
    return (((Pair*)a)->val - ((Pair*)b)->val);
}

int* advantageShuffle(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    *returnSize = nums1Size;
    int* ans = (int*)malloc(nums1Size * sizeof(int));

    // Sort nums1 in ascending order
    qsort(nums1, nums1Size, sizeof(int), compareInt);

    // Create an array of Pair structs for nums2 to keep track of original indices
    Pair* nums2_indexed = (Pair*)malloc(nums2Size * sizeof(Pair));
    for (int i = 0; i < nums2Size; i++) {
        nums2_indexed[i].val = nums2[i];
        nums2_indexed[i].original_idx = i;
    }

    // Sort nums2_indexed based on the 'val' field in ascending order
    qsort(nums2_indexed, nums2Size, sizeof(Pair), comparePair);

    // Two pointers for nums1 (sorted)
    int left1 = 0;
    int right1 = nums1Size - 1;

    // Pointer for nums2_indexed (sorted), iterating from largest to smallest
    int right2 = nums2Size - 1;

    // Iterate through nums2_indexed from largest element to smallest
    while (right2 >= 0) {
        // Get the current largest element from nums2_indexed
        int b_val = nums2_indexed[right2].val;
        int b_original_idx = nums2_indexed[right2].original_idx;

        // If the largest remaining element in nums1 can beat the current largest element in nums2
        if (nums1[right1] > b_val) {
            // Use nums1[right1] to beat b_val. This is the most efficient use of nums1[right1]
            // as it beats the strongest possible opponent without wasting its "strength" on a weaker one.
            ans[b_original_idx] = nums1[right1];
            right1--; // Move to the next largest element in nums1
        } else {
            // nums1[right1] cannot beat b_val.
            // Since nums1[right1] is the largest available element in nums1,
            // and it cannot beat b_val, it means no other remaining element in nums1
            // (from left1 to right1) can beat b_val either.
            // In this "losing" scenario, we sacrifice the smallest available element from nums1 (nums1[left1])
            // to b_val. This preserves stronger elements for other potential wins against smaller b_vals.
            ans[b_original_idx] = nums1[left1];
            left1++; // Move to the next smallest element in nums1
        }
        right2--; // Move to the next largest element in nums2_indexed
    }

    free(nums2_indexed); // Free the dynamically allocated memory for nums2_indexed

    return ans;
}