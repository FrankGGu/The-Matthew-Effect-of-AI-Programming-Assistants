#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* beautifulIndices(char * s, char * a, char * b, int k, int* returnSize){
    int n = strlen(s);
    int len_a = strlen(a);
    int len_b = strlen(b);

    int* indices_a = (int*)malloc(sizeof(int) * n);
    int count_a = 0;
    for (int i = 0; i <= n - len_a; i++) {
        if (strncmp(s + i, a, len_a) == 0) {
            indices_a[count_a++] = i;
        }
    }

    int* indices_b = (int*)malloc(sizeof(int) * n);
    int count_b = 0;
    for (int i = 0; i <= n - len_b; i++) {
        if (strncmp(s + i, b, len_b) == 0) {
            indices_b[count_b++] = i;
        }
    }

    int* result = (int*)malloc(sizeof(int) * n);
    int result_count = 0;
    for (int i = 0; i < count_a; i++) {
        for (int j = 0; j < count_b; j++) {
            if (abs(indices_a[i] - indices_b[j]) <= k) {
                result[result_count++] = indices_a[i];
                break;
            }
        }
    }

    int* final_result = (int*)malloc(sizeof(int) * result_count);
    int final_result_count = 0;
    int used[n];
    memset(used, 0, sizeof(used));
    for (int i = 0; i < result_count; i++) {
        int found = 0;
        for(int j=0; j<final_result_count; j++){
            if(result[i] == final_result[j]){
                found = 1;
                break;
            }
        }
        if(!found){
            final_result[final_result_count++] = result[i];
        }
    }

    for(int i=0; i<final_result_count; i++){
        for(int j=i+1; j<final_result_count; j++){
            if(final_result[i] > final_result[j]){
                int temp = final_result[i];
                final_result[i] = final_result[j];
                final_result[j] = temp;
            }
        }
    }

    *returnSize = final_result_count;

    free(indices_a);
    free(indices_b);
    free(result);

    return final_result;
}