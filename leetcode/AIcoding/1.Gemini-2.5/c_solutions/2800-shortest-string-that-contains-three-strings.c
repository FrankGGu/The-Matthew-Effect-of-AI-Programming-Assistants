#include <stdlib.h> // For malloc, free, strdup
#include <string.h> // For strlen, strcpy, strcat, strncmp, strstr, strcmp
#include <limits.h> // For INT_MAX

static int min(int a, int b) {
    return (a < b) ? a : b;
}

static void update_best_result(char* current_str, char** best_res_ptr, int* best_len_ptr) {
    if (current_str == NULL) {
        return;
    }

    int current_len = strlen(current_str);
    if (current_len < *best_len_ptr) {
        if (*best_res_ptr != NULL) {
            free(*best_res_ptr);
        }
        *best_res_ptr = strdup(current_str);
        *best_len_ptr = current_len;
    } else if (current_len == *best_len_ptr) {
        if (*best_res_ptr == NULL || strcmp(current_str, *best_res_ptr) < 0) {
            if (*best_res_ptr != NULL) {
                free(*best_res_ptr);
            }
            *best_res_ptr = strdup(current_str);
        }
    }
}

static char* calculate_overlap_merge(char* s1, char* s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int max_overlap = 0;

    for (int i = 1; i <= min(len1, len2); ++i) {
        // Check if suffix of s1 of length i matches prefix of s2 of length i
        if (strncmp(s1 + len1 - i, s2, i) == 0) {
            max_overlap = i;
        }
    }

    int merged_len = len1 + len2 - max_overlap;
    char* res = (char*)malloc(merged_len + 1);
    if (res == NULL) return NULL; // Handle allocation failure
    strcpy(res, s1);
    strcpy(res + len1, s2 + max_overlap); // Append remaining part of s2
    res[merged_len] = '\0';
    return res;
}

static char* merge_two_strings(char* a, char* b) {
    char* best_res = NULL;
    int best_len = INT_MAX;

    // Case 1: 'a' contains 'b'
    if (strstr(a, b) != NULL) {
        update_best_result(a, &best_res, &best_len);
    }
    // Case 2: 'b' contains 'a'
    if (strstr(b, a) != NULL) {
        update_best_result(b, &best_res, &best_len);
    }

    // Case 3: 'a' followed by 'b' with overlap
    char* merged_ab = calculate_overlap_merge(a, b);
    update_best_result(merged_ab, &best_res, &best_len);
    free(merged_ab);

    // Case 4: 'b' followed by 'a' with overlap
    char* merged_ba = calculate_overlap_merge(b, a);
    update_best_result(merged_ba, &best_res, &best_len);
    free(merged_ba);

    return best_res;
}

char* shortestSuperstring(char* s1, char* s2, char* s3) {
    char* strings[3] = {s1, s2, s3};
    int p[3]; // To store permutation indices

    char* overall_best_res = NULL;
    int overall_best_len = INT_MAX;

    // Iterate through all 6 permutations of (s1, s2, s3)
    // Permutation 1: (0, 1, 2)
    p[0] = 0; p[1] = 1; p[2] = 2;
    char* temp1 = merge_two_strings(strings[p[0]], strings[p[1]]);
    char* final_res = merge_two_strings(temp1, strings[p[2]]);
    update_best_result(final_res, &overall_best_res, &overall_best_len);
    free(temp1);
    free(final_res);

    // Permutation 2: (0, 2, 1)
    p[0] = 0; p[1] = 2; p[2] = 1;
    temp1 = merge_two_strings(strings[p[0]], strings[p[1]]);
    final_res = merge_two_strings(temp1, strings[p[2]]);
    update_best_result(final_res, &overall_best_res, &overall_best_len);
    free(temp1);
    free(final_res);

    // Permutation 3: (1, 0, 2)
    p[0] = 1; p[1] = 0; p[2] = 2;
    temp1 = merge_two_strings(strings[p[0]], strings[p[1]]);
    final_res = merge_two_strings(temp1, strings[p[2]]);
    update_best_result(final_res, &overall_best_res, &overall_best_len);
    free(temp1);
    free(final_res);

    // Permutation 4: (1, 2, 0)
    p[0] = 1; p[1] = 2; p[2] = 0;
    temp1 = merge_two_strings(strings[p[0]], strings[p[1]]);
    final_res = merge_two_strings(temp1, strings[p[2]]);
    update_best_result(final_res, &overall_best_res, &overall_best_len);
    free(temp1);
    free(final_res);

    // Permutation 5: (2, 0, 1)
    p[0] = 2; p[1] = 0; p[2] = 1;
    temp1 = merge_two_strings(strings[p[0]], strings[p[1]]);
    final_res = merge_two_strings(temp1, strings[p[2]]);
    update_best_result(final_res, &overall_best_res, &overall_best_len);
    free(temp1);
    free(final_res);

    // Permutation 6: (2, 1, 0)
    p[0] = 2; p[1] = 1; p[2] = 0;
    temp1 = merge_two_strings(strings[p[0]], strings[p[1]]);
    final_res = merge_two_strings(temp1, strings[p[2]]);
    update_best_result(final_res, &overall_best_res, &overall_best_len);
    free(temp1);
    free(final_res);

    return overall_best_res;
}