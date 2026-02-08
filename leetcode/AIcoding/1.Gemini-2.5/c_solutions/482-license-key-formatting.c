#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* licenseKeyFormatting(char* s, int k) {
    int n = strlen(s);
    char* clean_s = (char*)malloc(sizeof(char) * (n + 1));
    int clean_idx = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] != '-') {
            clean_s[clean_idx++] = toupper(s[i]);
        }
    }
    clean_s[clean_idx] = '\0';
    int clean_len = clean_idx;

    if (clean_len == 0) {
        free(clean_s);
        char* result = (char*)malloc(sizeof(char));
        result[0] = '\0';
        return result;
    }

    int num_groups = (clean_len + k - 1) / k;
    int num_dashes = (clean_len > 0) ? (num_groups - 1) : 0;

    int result_len = clean_len + num_dashes;
    char* result = (char*)malloc(sizeof(char) * (result_len + 1));

    int res_ptr = result_len - 1;
    int clean_ptr = clean_len - 1;
    int current_group_count = 0;

    while (clean_ptr >= 0) {
        result[res_ptr--] = clean_s[clean_ptr--];
        current_group_count++;

        if (current_group_count == k && clean_ptr >= 0) {
            result[res_ptr--] = '-';
            current_group_count = 0;
        }
    }
    result[result_len] = '\0';

    free(clean_s);
    return result;
}