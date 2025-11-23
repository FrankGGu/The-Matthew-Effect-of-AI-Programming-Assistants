#include <stdlib.h>
#include <string.h>
#include <math.h> // For abs, though direct comparison is used

void computeLPSArray(const char* pattern, int M, int* lps) {
    int len = 0; // length of the previous longest prefix suffix
    lps[0] = 0; // lps[0] is always 0
    int i = 1;

    while (i < M) {
        if (pattern[i] == pattern[len]) {
            len++;
            lps[i] = len;
            i++;
        } else {
            if (len != 0) {
                len = lps[len - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }
}

int* KMPSearch(const char* text, const char* pattern, int* returnSize) {
    int N = strlen(text);
    int M = strlen(pattern);

    if (M == 0) {
        *returnSize = 0;
        return NULL;
    }
    if (M > N) {
        *returnSize = 0;
        return NULL;
    }

    int* lps = (int*)malloc(sizeof(int) * M);
    if (!lps) {
        *returnSize = 0;
        return NULL;
    }
    computeLPSArray(pattern, M, lps);

    int* matches = NULL;
    int matches_capacity = 0;
    int matches_count = 0;

    int i = 0; // index for text[]
    int j = 0; // index for pattern[]

    while (i < N) {
        if (pattern[j] == text[i]) {
            i++;
            j++;
        }

        if (j == M) {
            // Match found at (i - j)
            if (matches_count == matches_capacity) {
                matches_capacity = (matches_capacity == 0) ? 1 : matches_capacity * 2;
                int* new_matches = (int*)realloc(matches, sizeof(int) * matches_capacity);
                if (!new_matches) {
                    free(lps);
                    free(matches);
                    *returnSize = 0;
                    return NULL;
                }
                matches = new_matches;
            }
            matches[matches_count++] = i - j;
            j = lps[j - 1]; // Move to find next match
        } else if (i < N && pattern[j] != text[i]) {
            if (j != 0) {
                j = lps[j - 1];
            } else {
                i++;
            }
        }
    }

    free(lps);
    *returnSize = matches_count;
    return matches;
}

int* beautifulIndices(char* s, char* a, char* b, int k, int* returnSize) {
    int* indices_a = NULL;
    int count_a = 0;
    indices_a = KMPSearch(s, a, &count_a);

    int* indices_b = NULL;
    int count_b = 0;
    indices_b = KMPSearch(s, b, &count_b);

    int* result = NULL;
    int result_capacity = 0;
    int result_count = 0;

    if (count_a == 0 || count_b == 0) {
        *returnSize = 0;
        free(indices_a);
        free(indices_b);
        return NULL;
    }

    int ptr_b = 0;
    for (int i_idx = 0; i_idx < count_a; i_idx++) {
        int current_i = indices_a[i_idx];

        // Advance ptr_b to the first index in indices_b that is >= current_i - k
        while (ptr_b < count_b && indices_b[ptr_b] < current_i - k) {
            ptr_b++;
        }

        // Check if there is any j in indices_b such that abs(current_i - j) <= k
        // This means j must be in [current_i - k, current_i + k].
        // Since ptr_b is now at the first element >= current_i - k,
        // we just need to check if that element is also <= current_i + k.
        if (ptr_b < count_b && indices_b[ptr_b] <= current_i + k) {
            // Found a beautiful index i
            if (result_count == result_capacity) {
                result_capacity = (result_capacity == 0) ? 1 : result_capacity * 2;
                int* new_result = (int*)realloc(result, sizeof(int) * result_capacity);
                if (!new_result) {
                    free(indices_a);
                    free(indices_b);
                    free(result);
                    *returnSize = 0;
                    return NULL;
                }
                result = new_result;
            }
            result[result_count++] = current_i;
        }
    }

    free(indices_a);
    free(indices_b);
    *returnSize = result_count;
    return result;
}