#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

int* get_diff_array(char* s, int len) {
    if (len <= 1) {
        return NULL;
    }
    int* diff = (int*)malloc(sizeof(int) * (len - 1));
    if (diff == NULL) {
        return NULL; // Handle allocation failure
    }
    for (int i = 0; i < len - 1; i++) {
        diff[i] = s[i+1] - s[i];
    }
    return diff;
}

bool are_diff_arrays_equal(int* arr1, int* arr2, int len_diff) {
    if (arr1 == NULL || arr2 == NULL) {
        return false;
    }
    for (int i = 0; i < len_diff; i++) {
        if (arr1[i] != arr2[i]) {
            return false;
        }
    }
    return true;
}

char* oddString(char** words, int wordsSize, int* wordsColSize) {
    int word_len = wordsColSize[0];
    int diff_len = word_len - 1;

    int* diff0 = get_diff_array(words[0], word_len);
    int* diff1 = get_diff_array(words[1], word_len);

    if (are_diff_arrays_equal(diff0, diff1, diff_len)) {
        for (int i = 2; i < wordsSize; i++) {
            int* diff_current = get_diff_array(words[i], word_len);
            if (!are_diff_arrays_equal(diff0, diff_current, diff_len)) {
                free(diff0);
                free(diff1);
                free(diff_current);
                return words[i];
            }
            free(diff_current);
        }
    } else {
        int* diff2 = get_diff_array(words[2], word_len);
        if (are_diff_arrays_equal(diff0, diff2, diff_len)) {
            free(diff0);
            free(diff1);
            free(diff2);
            return words[1];
        } else {
            free(diff0);
            free(diff1);
            free(diff2);
            return words[0];
        }
    }

    // This part should not be reached based on problem constraints
    // (guaranteed exactly one string with a different difference array).
    return NULL; 
}