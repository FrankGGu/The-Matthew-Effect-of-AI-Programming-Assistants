#define MAX_SIZE 1000

void backtrack(int** res, int* returnSize, int* returnColumnSizes, int* candidates, int candidatesSize, int target, int start, int* combination, int combinationSize) {
    if (target == 0) {
        res[*returnSize] = malloc(sizeof(int) * combinationSize);
        memcpy(res[*returnSize], combination, sizeof(int) * combinationSize);
        returnColumnSizes[*returnSize] = combinationSize;
        (*returnSize)++;
        return;
    }
    for (int i = start; i < candidatesSize; i++) {
        if (i > start && candidates[i] == candidates[i - 1]) continue;
        if (candidates[i] > target) break;
        combination[combinationSize] = candidates[i];
        backtrack(res, returnSize, returnColumnSizes, candidates, candidatesSize, target - candidates[i], i + 1, combination, combinationSize + 1);
    }
}

int** combinationSum2(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    qsort(candidates, candidatesSize, sizeof(int), cmp);
    *returnSize = 0;
    int** res = malloc(MAX_SIZE * sizeof(int*));
    *returnColumnSizes = malloc(MAX_SIZE * sizeof(int));
    int* combination = malloc(MAX_SIZE * sizeof(int));
    backtrack(res, returnSize, *returnColumnSizes, candidates, candidatesSize, target, 0, combination, 0);
    free(combination);
    return res;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}