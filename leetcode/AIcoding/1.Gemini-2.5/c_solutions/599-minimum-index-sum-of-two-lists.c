#include <stdlib.h> // For malloc, realloc, free
#include <string.h> // For strcmp, strlen, strcpy
#include <limits.h> // For INT_MAX

char** findRestaurant(char** list1, int list1Size, char** list2, int list2Size, int* returnSize) {
    int min_index_sum = INT_MAX;
    char** result = NULL;
    int result_count = 0;
    int result_capacity = 0;

    for (int i = 0; i < list1Size; i++) {
        // Optimization: If the current index 'i' is already greater than or equal to
        // the minimum index sum found so far, then any subsequent sum (i + j)
        // will also be greater than or equal to min_index_sum (since j >= 0).
        // If i > min_index_sum, then i+j > min_index_sum for any j >= 0.
        // If i == min_index_sum, then only j=0 could potentially yield min_index_sum.
        // If i > min_index_sum, we can safely break the outer loop.
        if (i > min_index_sum) {
            break;
        }

        for (int j = 0; j < list2Size; j++) {
            // Optimization: If the current potential sum (i + j) already exceeds
            // the minimum index sum found so far, then any further 'j' for this 'i'
            // will only increase the sum, so we can break the inner loop.
            if (i + j > min_index_sum) {
                break;
            }

            if (strcmp(list1[i], list2[j]) == 0) {
                int current_sum = i + j;

                if (current_sum < min_index_sum) {
                    min_index_sum = current_sum;

                    // A new minimum sum is found, clear previous results
                    for (int k = 0; k < result_count; k++) {
                        free(result[k]);
                    }
                    if (result != NULL) {
                        free(result);
                    }
                    result = NULL;
                    result_count = 0;
                    result_capacity = 0;

                    // Add the current string to the result list
                    result_capacity = 1;
                    result = (char**)malloc(sizeof(char*) * result_capacity);
                    result[result_count] = (char*)malloc(sizeof(char) * (strlen(list1[i]) + 1));
                    strcpy(result[result_count], list1[i]);
                    result_count++;
                } else if (current_sum == min_index_sum) {
                    // This string also has the minimum sum, add it to the result list
                    if (result_count == result_capacity) {
                        result_capacity *= 2; // Double capacity
                        result = (char**)realloc(result, sizeof(char*) * result_capacity);
                    }
                    result[result_count] = (char*)malloc(sizeof(char) * (strlen(list1[i]) + 1));
                    strcpy(result[result_count], list1[i]);
                    result_count++;
                }
            }
        }
    }

    *returnSize = result_count;
    return result;
}