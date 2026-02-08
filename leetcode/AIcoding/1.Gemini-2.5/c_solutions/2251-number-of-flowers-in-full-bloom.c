#include <stdlib.h> // For malloc, qsort, free

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int get_lower_bound_idx(int* arr, int size, int val) {
    int low = 0;
    int high = size; // Exclusive upper bound
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] < val) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}

int get_upper_bound_idx(int* arr, int size, int val) {
    int low = 0;
    int high = size; // Exclusive upper bound
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] <= val) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}

int* fullBloomFlowers(int** flowers, int flowersSize, int* flowersColSize, int* people, int peopleSize, int* returnSize) {
    *returnSize = peopleSize;
    int* result = (int*)malloc(peopleSize * sizeof(int));
    if (!result) {
        return NULL; // Handle allocation failure
    }

    if (flowersSize == 0) {
        for (int i = 0; i < peopleSize; ++i) {
            result[i] = 0;
        }
        return result;
    }

    int* start_times = (int*)malloc(flowersSize * sizeof(int));
    int* end_times = (int*)malloc(flowersSize * sizeof(int));

    if (!start_times || !end_times) {
        free(result);
        free(start_times); 
        free(end_times);
        return NULL; // Handle allocation failure
    }

    for (int i = 0; i < flowersSize; ++i) {
        start_times[i] = flowers[i][0];
        end_times[i] = flowers[i][1];
    }

    qsort(start_times, flowersSize, sizeof(int), compare);
    qsort(end_times, flowersSize, sizeof(int), compare);

    for (int i = 0; i < peopleSize; ++i) {
        int person_time = people[i];

        // Count flowers that have started blooming by person_time (inclusive)
        // This is the count of elements in start_times <= person_time
        int started_count = get_upper_bound_idx(start_times, flowersSize, person_time);

        // Count flowers that have ended blooming strictly before person_time
        // This is the count of elements in end_times < person_time
        int ended_before_count = get_lower_bound_idx(end_times, flowersSize, person_time);

        result[i] = started_count - ended_before_count;
    }

    free(start_times);
    free(end_times);

    return result;
}