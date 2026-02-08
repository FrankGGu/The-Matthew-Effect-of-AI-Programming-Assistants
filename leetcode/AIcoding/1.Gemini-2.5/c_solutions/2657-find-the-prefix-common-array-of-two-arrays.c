#include <stdlib.h>

int* findThePrefixCommonArray(int* A, int ASize, int* B, int BSize, int* returnSize) {
    int n = ASize;
    *returnSize = n;

    int* result = (int*)malloc(sizeof(int) * n);
    if (result == NULL) {
        return NULL;
    }

    char* present_in_A = (char*)calloc(n + 1, sizeof(char));
    char* present_in_B = (char*)calloc(n + 1, sizeof(char));

    if (present_in_A == NULL || present_in_B == NULL) {
        free(result);
        free(present_in_A);
        free(present_in_B);
        return NULL;
    }

    int common_count = 0;

    for (int k = 0; k < n; k++) {
        int a_val = A[k];
        int b_val = B[k];

        if (present_in_A[a_val] == 0) {
            present_in_A[a_val] = 1;
            if (present_in_B[a_val] == 1) {
                common_count++;
            }
        }

        if (present_in_B[b_val] == 0) {
            present_in_B[b_val] = 1;
            if (present_in_A[b_val] == 1) {
                common_count++;
            }
        }

        result[k] = common_count;
    }

    free(present_in_A);
    free(present_in_B);

    return result;
}