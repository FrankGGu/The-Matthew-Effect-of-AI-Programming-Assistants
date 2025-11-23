#include <stdlib.h>
#include <string.h> // For memcpy if needed, but direct assignment is fine here

int** groupThePeople(int* groupSizes, int groupSizesSize, int* returnSize, int** returnColumnSizes) {
    // max_group_size can be up to groupSizesSize
    int max_group_size = groupSizesSize;

    // Temporary storage for people by their group size
    // groups_by_size_data[k] will store an array of people indices belonging to group size k
    int** groups_by_size_data = (int**)malloc(sizeof(int*) * (max_group_size + 1));
    // groups_by_size_counts[k] stores the current number of people in groups_by_size_data[k]
    int* groups_by_size_counts = (int*)calloc(max_group_size + 1, sizeof(int));
    // groups_by_size_capacities[k] stores the allocated capacity for groups_by_size_data[k]
    int* groups_by_size_capacities = (int*)calloc(max_group_size + 1, sizeof(int));

    // Initialize temporary storage for each group size
    for (int i = 0; i <= max_group_size; ++i) {
        groups_by_size_capacities[i] = 4; // Initial capacity for dynamic array
        groups_by_size_data[i] = (int*)malloc(sizeof(int) * groups_by_size_capacities[i]);
    }

    // Result storage: dynamic array of int* (each int* is a group)
    int** result_groups = NULL;
    // Result column sizes: dynamic array of int (size of each group)
    int* result_col_sizes = NULL;
    int result_count = 0;
    int result_capacity = 16; // Initial capacity for the result arrays

    result_groups = (int**)malloc(sizeof(int*) * result_capacity);
    result_col_sizes = (int*)malloc(sizeof(int) * result_capacity);

    // Iterate through each person
    for (int i = 0; i < groupSizesSize; ++i) {
        int size = groupSizes[i];

        // Add person 'i' to the temporary list for their group 'size'
        if (groups_by_size_counts[size] == groups_by_size_capacities[size]) {
            groups_by_size_capacities[size] *= 2;
            groups_by_size_data[size] = (int*)realloc(groups_by_size_data[size], sizeof(int) * groups_by_size_capacities[size]);
        }
        groups_by_size_data[size][groups_by_size_counts[size]++] = i;

        // If a full group of 'size' is formed
        if (groups_by_size_counts[size] == size) {
            // Check if result storage needs expansion
            if (result_count == result_capacity) {
                result_capacity *= 2;
                result_groups = (int**)realloc(result_groups, sizeof(int*) * result_capacity);
                result_col_sizes = (int*)realloc(result_col_sizes, sizeof(int) * result_capacity);
            }

            // Create a new array for the current group
            int* current_group = (int*)malloc(sizeof(int) * size);
            // Copy people from the temporary list to the new group
            for (int j = 0; j < size; ++j) {
                current_group[j] = groups_by_size_data[size][j];
            }

            // Add the new group to the result
            result_groups[result_count] = current_group;
            result_col_sizes[result_count] = size;
            result_count++;

            // Reset the count for this group size, effectively clearing it for the next group
            groups_by_size_counts[size] = 0;
        }
    }

    // Set the return values for LeetCode's test harness
    *returnSize = result_count;
    *returnColumnSizes = result_col_sizes;

    // Free temporary memory used for `groups_by_size`
    for (int i = 0; i <= max_group_size; ++i) {
        free(groups_by_size_data[i]);
    }
    free(groups_by_size_data);
    free(groups_by_size_counts);
    free(groups_by_size_capacities);

    return result_groups;
}