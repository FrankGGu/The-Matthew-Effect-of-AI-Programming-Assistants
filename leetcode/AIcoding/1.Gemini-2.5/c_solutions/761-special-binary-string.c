#include <stdlib.h>
#include <string.h>

int compareStringsDesc(const void* a, const void* b) {
    const char* str1 = *(const char**)a;
    const char* str2 = *(const char**)b;
    return strcmp(str2, str1);
}

char* specialBinaryString(char* S) {
    size_t n = strlen(S);

    if (n == 0) {
        return strdup("");
    }

    char** res_arr = NULL;
    int res_count = 0;
    int res_capacity = 0;

    int balance = 0;
    size_t start = 0;

    for (size_t i = 0; i < n; i++) {
        if (S[i] == '1') {
            balance++;
        } else {
            balance--;
        }

        if (balance == 0) {
            size_t inner_len = i - (start + 1);
            char* inner_S = (char*)malloc(sizeof(char) * (inner_len + 1));
            strncpy(inner_S, S + start + 1, inner_len);
            inner_S[inner_len] = '\0';

            char* inner_result = specialBinaryString(inner_S);
            free(inner_S);

            size_t current_special_string_len = 1 + strlen(inner_result) + 1;
            char* current_special_string = (char*)malloc(sizeof(char) * (current_special_string_len + 1));
            strcpy(current_special_string, "1");
            strcat(current_special_string, inner_result);
            strcat(current_special_string, "0");
            free(inner_result);

            if (res_count == res_capacity) {
                res_capacity = (res_capacity == 0) ? 1 : res_capacity * 2;
                res_arr = (char**)realloc(res_arr, res_capacity * sizeof(char*));
            }
            res_arr[res_count++] = current_special_string;

            start = i + 1;
        }
    }

    qsort(res_arr, res_count, sizeof(char*), compareStringsDesc);

    size_t total_len = 0;
    for (int k = 0; k < res_count; k++) {
        total_len += strlen(res_arr[k]);
    }

    char* final_result = (char*)malloc(sizeof(char) * (total_len + 1));
    final_result[0] = '\0';

    for (int k = 0; k < res_count; k++) {
        strcat(final_result, res_arr[k]);
        free(res_arr[k]);
    }
    free(res_arr);

    return final_result;
}