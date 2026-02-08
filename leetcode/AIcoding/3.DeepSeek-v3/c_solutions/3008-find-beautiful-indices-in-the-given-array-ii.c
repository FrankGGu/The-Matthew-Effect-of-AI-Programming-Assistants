#include <stdlib.h>
#include <string.h>

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* beautifulIndices(char* s, char* a, char* b, int k, int* returnSize) {
    int n = strlen(s);
    int len_a = strlen(a);
    int len_b = strlen(b);

    // Find all occurrences of a in s
    int* a_indices = (int*)malloc(n * sizeof(int));
    int a_count = 0;

    for (int i = 0; i <= n - len_a; i++) {
        if (strncmp(s + i, a, len_a) == 0) {
            a_indices[a_count++] = i;
        }
    }

    // Find all occurrences of b in s
    int* b_indices = (int*)malloc(n * sizeof(int));
    int b_count = 0;

    for (int i = 0; i <= n - len_b; i++) {
        if (strncmp(s + i, b, len_b) == 0) {
            b_indices[b_count++] = i;
        }
    }

    // Find beautiful indices
    int* result = (int*)malloc(a_count * sizeof(int));
    int result_count = 0;

    for (int i = 0; i < a_count; i++) {
        int idx_a = a_indices[i];
        int found = 0;

        // Binary search for the closest b index
        int left = 0, right = b_count - 1;
        while (left <= right && !found) {
            int mid = left + (right - left) / 2;
            int idx_b = b_indices[mid];

            if (abs(idx_b - idx_a) <= k) {
                found = 1;
            } else if (idx_b < idx_a) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        // Check nearby positions for a match
        if (!found && b_count > 0) {
            // Check positions around the binary search result
            for (int j = left; j < b_count && j <= left + 2; j++) {
                if (j >= 0 && j < b_count && abs(b_indices[j] - idx_a) <= k) {
                    found = 1;
                    break;
                }
            }
            for (int j = left - 1; j >= 0 && j >= left - 2; j--) {
                if (j >= 0 && j < b_count && abs(b_indices[j] - idx_a) <= k) {
                    found = 1;
                    break;
                }
            }
        }

        if (found) {
            result[result_count++] = idx_a;
        }
    }

    free(a_indices);
    free(b_indices);

    *returnSize = result_count;
    return result;
}