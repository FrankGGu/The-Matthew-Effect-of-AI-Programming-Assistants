#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

int compareChars(const void *a, const void *b) {
    return (*(char*)a - *(char*)b);
}

bool canBreakHelper(char* s1_sorted, char* s2_sorted, int n) {
    for (int i = 0; i < n; i++) {
        if (s1_sorted[i] < s2_sorted[i]) {
            return false;
        }
    }
    return true;
}

bool checkIfCanBreak(char * s1, char * s2) {
    int n = strlen(s1);

    char* sorted_s1 = (char*)malloc((n + 1) * sizeof(char));
    char* sorted_s2 = (char*)malloc((n + 1) * sizeof(char));

    strcpy(sorted_s1, s1);
    strcpy(sorted_s2, s2);

    qsort(sorted_s1, n, sizeof(char), compareChars);
    qsort(sorted_s2, n, sizeof(char), compareChars);

    bool result = canBreakHelper(sorted_s1, sorted_s2, n) || canBreakHelper(sorted_s2, sorted_s1, n);

    free(sorted_s1);
    free(sorted_s2);

    return result;
}