#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void combine_recursive(int n, int k, int start, int *combination, int combination_index, int **result, int *result_index) {
    if (combination_index == k) {
        int *new_combination = (int *)malloc(sizeof(int) * k);
        for (int i = 0; i < k; i++) {
            new_combination[i] = combination[i];
        }
        result[*result_index] = new_combination;
        (*result_index)++;
        return;
    }

    for (int i = start; i <= n; i++) {
        combination[combination_index] = i;
        combine_recursive(n, k, i + 1, combination, combination_index + 1, result, result_index);
    }
}

int** combine(int n, int k, int* returnSize, int** returnColumnSizes){
    *returnSize = 0;
    int num_combinations = 1;
    for (int i = 0; i < k; i++) {
        num_combinations = num_combinations * (n - i) / (i + 1);
    }
    *returnSize = num_combinations;

    int **result = (int **)malloc(sizeof(int *) * num_combinations);
    *returnColumnSizes = (int *)malloc(sizeof(int) * num_combinations);
    for (int i = 0; i < num_combinations; i++) {
        (*returnColumnSizes)[i] = k;
    }

    int *combination = (int *)malloc(sizeof(int) * k);
    int result_index = 0;

    combine_recursive(n, k, 1, combination, 0, result, &result_index);

    free(combination);
    return result;
}