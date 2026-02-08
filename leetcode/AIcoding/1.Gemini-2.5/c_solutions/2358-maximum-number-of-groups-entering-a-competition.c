#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxGroups(int* grades, int gradesSize) {
    if (gradesSize == 0) {
        return 0;
    }

    // Sort the grades in ascending order. This ensures that when we pick
    // students for a group, we always use the ones with the lowest available grades
    // to maximize the chances of future groups having strictly greater sums.
    qsort(grades, gradesSize, sizeof(int), compare);

    int num_groups = 0;
    long long prev_group_sum = 0; // Use long long for sums to prevent overflow
    int prev_group_size = 0;
    int current_student_idx = 0; // Index of the first student not yet assigned to a group

    // Iterate to form groups
    while (current_student_idx < gradesSize) {
        // The current group must have strictly more students than the previous group.
        // To maximize the number of groups, we take the smallest possible increment: +1 student.
        int current_group_size = prev_group_size + 1;

        // Check if there are enough students remaining to form the current group.
        if (current_student_idx + current_group_size > gradesSize) {
            break; // Not enough students left, cannot form this group or any further groups.
        }

        long long current_group_sum = 0;
        // Sum the grades of students for the current group.
        // These are the next `current_group_size` students from the sorted array.
        for (int i = 0; i < current_group_size; ++i) {
            current_group_sum += grades[current_student_idx + i];
        }

        // Check the second condition: the sum of grades of the current group
        // must be strictly greater than the sum of grades of the previous group.
        // The first condition (current_group_size > prev_group_size) is guaranteed
        // by how `current_group_size` is calculated (`prev_group_size + 1`).
        if (current_group_sum > prev_group_sum) {
            // If both conditions are met, we successfully form a group.
            num_groups++;
            prev_group_size = current_group_size;
            prev_group_sum = current_group_sum;
            // Move the starting index for the next group past the students just used.
            current_student_idx += current_group_size;
        } else {
            // If the sum condition is not met, we cannot form this group.
            // Since we are using the smallest possible group size increment and
            // the smallest available grades, if this configuration fails,
            // no other configuration for this group (or subsequent groups)
            // would allow us to form more groups. Thus, we stop.
            break;
        }
    }

    return num_groups;
}