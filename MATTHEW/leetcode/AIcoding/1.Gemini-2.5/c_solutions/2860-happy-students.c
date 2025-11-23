#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int happyStudents(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int happy_ways = 0;

    // Case 1: Select 0 students
    // If 0 students are selected, all students are unselected.
    // For all unselected students to be unhappy, the number of selected students (0)
    // must be less than or equal to their nums[i] values.
    // i.e., 0 <= nums[i] for all i.
    // Since nums[i] are non-negative, this condition is always true.
    // So, selecting 0 students is always a valid way.
    happy_ways = 1;

    // Case 2: Select k students, where 1 <= k < numsSize
    // We assume the k students with the smallest nums[i] values are selected.
    // These are nums[0], ..., nums[k-1].
    // The unselected students are nums[k], ..., nums[numsSize-1].
    for (int k = 1; k < numsSize; k++) {
        // Condition for selected students to be happy:
        // k > nums[i] for all i from 0 to k-1.
        // Since nums is sorted, this is equivalent to k > nums[k-1].

        // Condition for unselected students to be unhappy:
        // k <= nums[j] for all j from k to numsSize-1.
        // Since nums is sorted, this is equivalent to k <= nums[k].

        if (k > nums[k-1] && k <= nums[k]) {
            happy_ways++;
        }
    }

    // Case 3: Select numsSize students (all students)
    // If all students are selected, all students must be happy.
    // i.e., numsSize > nums[i] for all i from 0 to numsSize-1.
    // Since nums is sorted, this is equivalent to numsSize > nums[numsSize-1].
    if (numsSize > nums[numsSize-1]) {
        happy_ways++;
    }

    return happy_ways;
}