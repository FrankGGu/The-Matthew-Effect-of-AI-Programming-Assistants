#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int compareStrings(const void* a, const void* b) {
    const char* str_a = *(const char**)a;
    const char* str_b = *(const char**)b;
    return strcmp(str_a, str_b);
}

int numDifferentIntegers(char* word) {
    char** numbers_found = NULL;
    int capacity = 10;
    int count = 0;

    numbers_found = (char**)malloc(capacity * sizeof(char*));
    if (numbers_found == NULL) {
        return 0;
    }

    int len = strlen(word);
    int i = 0;
    while (i < len) {
        if (isdigit(word[i])) {
            int start_idx = i;

            while (word[start_idx] == '0' && isdigit(word[start_idx + 1])) {
                start_idx++;
            }

            int end_idx = start_idx;
            while (end_idx < len && isdigit(word[end_idx])) {
                end_idx++;
            }

            int num_len = end_idx - start_idx;
            char* num_str = (char*)malloc((num_len + 1) * sizeof(char));
            if (num_str == NULL) {
                for (int k = 0; k < count; k++) {
                    free(numbers_found[k]);
                }
                free(numbers_found);
                return 0;
            }
            memcpy(num_str, word + start_idx, num_len);
            num_str[num_len] = '\0';

            if (count == capacity) {
                capacity *= 2;
                char** new_numbers_found = (char**)realloc(numbers_found, capacity * sizeof(char*));
                if (new_numbers_found == NULL) {
                    free(num_str);
                    for (int k = 0; k < count; k++) {
                        free(numbers_found[k]);
                    }
                    free(numbers_found);
                    return 0;
                }
                numbers_found = new_numbers_found;
            }
            numbers_found[count++] = num_str;

            i = end_idx;
        } else {
            i++;
        }
    }

    if (count > 0) {
        qsort(numbers_found, count, sizeof(char*), compareStrings);
    }

    int unique_count = 0;
    if (count > 0) {
        unique_count = 1;
        for (int j = 1; j < count; j++) {
            if (strcmp(numbers_found[j], numbers_found[j-1]) != 0) {
                unique_count++;
            }
        }
    }

    for (int k = 0; k < count; k++) {
        free(numbers_found[k]);
    }
    free(numbers_found);

    return unique_count;
}