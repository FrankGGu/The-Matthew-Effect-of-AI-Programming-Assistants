#include <stdlib.h>
#include <string.h>
#include <stdio.h>

static int compareStrings(const void* a, const void* b) {
    const char** str_a = (const char**)a;
    const char** str_b = (const char**)b;

    size_t len_a = strlen(*str_a);
    size_t len_b = strlen(*str_b);

    char* s1s2 = (char*)malloc(len_a + len_b + 1);
    char* s2s1 = (char*)malloc(len_a + len_b + 1);

    strcpy(s1s2, *str_a);
    strcat(s1s2, *str_b);

    strcpy(s2s1, *str_b);
    strcat(s2s1, *str_a);

    int cmp = strcmp(s2s1, s1s2);

    free(s1s2);
    free(s2s1);

    return cmp;
}

char* largestNumber(int* nums, int numsSize) {
    if (numsSize == 0) {
        char* result = (char*)malloc(2);
        strcpy(result, "0");
        return result;
    }

    char** str_nums = (char**)malloc(numsSize * sizeof(char*));
    int total_len = 0;

    for (int i = 0; i < numsSize; i++) {
        // Max int is 2,147,483,647 (10 digits). Plus sign and null terminator.
        str_nums[i] = (char*)malloc(12 * sizeof(char)); 
        sprintf(str_nums[i], "%d", nums[i]);
        total_len += strlen(str_nums[i]);
    }

    qsort(str_nums, numsSize, sizeof(char*), compareStrings);

    // Check for all zeros case
    if (str_nums[0][0] == '0') {
        for (int i = 0; i < numsSize; i++) {
            free(str_nums[i]);
        }
        free(str_nums);
        char* result = (char*)malloc(2);
        strcpy(result, "0");
        return result;
    }

    char* result = (char*)malloc(total_len + 1);
    result[0] = '\0'; // Initialize as empty string

    for (int i = 0; i < numsSize; i++) {
        strcat(result, str_nums[i]);
        free(str_nums[i]);
    }
    free(str_nums);

    return result;
}