#include <stdlib.h>
#include <string.h>

int compareStringsAsNumbers(const void* a, const void* b) {
    // Cast void pointers to char** to get the actual string pointers
    const char* s1 = *(const char**)a;
    const char* s2 = *(const char**)b;

    // Get lengths of the strings
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    // Compare by length first
    // If s1 is longer, it represents a larger number. For descending order, it comes first.
    if (len1 > len2) {
        return -1; // s1 comes before s2
    }
    // If s2 is longer, it represents a larger number. For descending order, s1 comes after s2.
    if (len1 < len2) {
        return 1;  // s1 comes after s2
    }

    // If lengths are equal, compare lexicographically
    // For descending order, if s1 > s2 lexicographically, s1 comes before s2.
    // strcmp(s1, s2) returns > 0 if s1 > s2. We need -1 in that case.
    // So, return -strcmp(s1, s2).
    return -strcmp(s1, s2);
}

char* kthLargestNumber(char** nums, int numsSize, int k) {
    // Sort the array of strings using the custom comparison function
    qsort(nums, numsSize, sizeof(char*), compareStringsAsNumbers);

    // The Kth largest number will be at index k-1 after sorting in descending order
    return nums[k - 1];
}