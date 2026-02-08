#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int N_global;
int M_global;
int K_VAL_global; // This is (n - m), the number of elements removed AND number of elements modified
int* NUMS1_global;
int* NUMS2_global;
long long X_VAL_global; // x can be large, use long long

char memo[51][51][51][51]; // Using char to save memory, 0 for false, 1 for true, -1 for uncomputed

int compareLongLong(const void* a, const void* b) {
    long long valA = *(const long long*)a;
    long long valB = *(const long long*)b;
    if (valA < valB) return -1;
    if (valA > valB) return 1;
    return 0;
}

bool dp_solve(int i, int j, int modified_in_nums2, int removed_from_nums1) {
    // Base case 1: All elements of nums2 have been matched
    if (j == M_global) {
        // We have successfully formed nums2.
        // Now check if the total number of removed elements from nums1 is K_VAL_global.
        // The remaining (N_global - i) elements in nums1 must be removed.
        return (removed_from_nums1 + (N_global - i)) == K_VAL_global;
    }

    // Base case 2: All elements of nums1 have been processed, but nums2 not fully matched
    if (i == N_global) {
        return false;
    }

    // Check memoization table
    if (memo[i][j][modified_in_nums2][removed_from_nums1] != -1) {
        return memo[i][j][modified_in_nums2][removed_from_nums1];
    }

    bool res = false;

    // Option 1: Remove NUMS1_global[i]
    // We can only remove if we haven't reached the maximum allowed removals (K_VAL_global).
    if (removed_from_nums1 < K_VAL_global) {
        res = dp_solve(i + 1, j, modified_in_nums2, removed_from_nums1 + 1);
        if (res) {
            memo[i][j][modified_in_nums2][removed_from_nums1] = 1;
            return true;
        }
    }

    // Option 2: Match NUMS1_global[i] as unmodified to NUMS2_global[j]
    if (NUMS1_global[i] == NUMS2_global[j]) {
        res = dp_solve(i + 1, j + 1, modified_in_nums2, removed_from_nums1);
        if (res) {
            memo[i][j][modified_in_nums2][removed_from_nums1] = 1;
            return true;
        }
    }

    // Option 3: Match NUMS1_global[i] as modified (NUMS1_global[i] + X_VAL_global) to NUMS2_global[j]
    // We can only modify if we haven't reached the maximum allowed modifications (K_VAL_global).
    if (modified_in_nums2 < K_VAL_global && (long long)NUMS1_global[i] + X_VAL_global == NUMS2_global[j]) {
        res = dp_solve(i + 1, j + 1, modified_in_nums2 + 1, removed_from_nums1);
        if (res) {
            memo[i][j][modified_in_nums2][removed_from_nums1] = 1;
            return true;
        }
    }

    // If none of the options lead to a solution
    memo[i][j][modified_in_nums2][removed_from_nums1] = 0;
    return false;
}

int* findTheInteger(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    N_global = nums1Size;
    M_global = nums2Size;
    K_VAL_global = N_global - M_global; // Number of elements removed AND number of elements modified
    NUMS1_global = nums1;
    NUMS2_global = nums2;

    // Use a temporary array to store candidate x values
    // Max K_VAL_global + 1 candidates (when nums2[0] is formed by nums1[i]+x, and i elements are removed before it).
    // K_VAL_global can be up to 50, so 51 candidates.
    long long* candidates = (long long*)malloc(sizeof(long long) * (K_VAL_global + 1));
    int candidate_count = 0;

    // Generate candidate x values
    // nums2[0] must come from nums1[i] (after modification by x)
    // where i can range from 0 to K_VAL_global (as K_VAL_global elements can be removed before nums1[i])
    for (int i = 0; i <= K_VAL_global; ++i) {
        long long current_x = (long long)NUMS2_global[0] - NUMS1_global[i];

        // Reset memoization table for each new x
        memset(memo, -1, sizeof(memo));
        X_VAL_global = current_x;

        if (dp_solve(0, 0, 0, 0)) {
            candidates[candidate_count++] = current_x;
        }
    }

    // Sort candidates to easily unique them
    qsort(candidates, candidate_count, sizeof(long long), compareLongLong);

    // Create the result array with unique sorted values
    long long* result_temp = (long long*)malloc(sizeof(long long) * candidate_count);
    int result_count = 0;
    if (candidate_count > 0) {
        result_temp[result_count++] = candidates[0];
        for (int i = 1; i < candidate_count; ++i) {
            if (candidates[i] != candidates[i-1]) {
                result_temp[result_count++] = candidates[i];
            }
        }
    }

    // Convert long long result_temp to int* as required by the problem
    int* final_result = (int*)malloc(sizeof(int) * result_count);
    for (int i = 0; i < result_count; ++i) {
        final_result[i] = (int)result_temp[i];
    }

    free(candidates);
    free(result_temp);

    *returnSize = result_count;
    return final_result;
}