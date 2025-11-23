#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* beautifulIndices(char* s, char* a, char* b, int k, int* returnSize) {
    int n = strlen(s);
    int len_a = strlen(a);
    int len_b = strlen(b);

    int* indices_a = (int*)malloc(n * sizeof(int));
    int count_a = 0;
    for (int i = 0; i <= n - len_a; i++) {
        if (strncmp(s + i, a, len_a) == 0) {
            indices_a[count_a++] = i;
        }
    }

    int* indices_b = (int*)malloc(n * sizeof(int));
    int count_b = 0;
    for (int i = 0; i <= n - len_b; i++) {
        if (strncmp(s + i, b, len_b) == 0) {
            indices_b[count_b++] = i;
        }
    }

    int* result = (int*)malloc(n * sizeof(int));
    int result_count = 0;
    for (int i = 0; i < count_a; i++) {
        for (int j = 0; j < count_b; j++) {
            if (abs(indices_a[i] - indices_b[j]) <= k) {
                result[result_count++] = indices_a[i];
                break;
            }
        }
    }

    int* final_result = (int*)malloc(result_count * sizeof(int));
    int final_count = 0;
    int* seen = (int*)calloc(n, sizeof(int));

    for(int i = 0; i < result_count; i++){
        if(seen[result[i]] == 0){
            final_result[final_count++] = result[i];
            seen[result[i]] = 1;
        }
    }

    free(indices_a);
    free(indices_b);
    free(result);
    free(seen);

    *returnSize = final_count;
    return final_result;
}