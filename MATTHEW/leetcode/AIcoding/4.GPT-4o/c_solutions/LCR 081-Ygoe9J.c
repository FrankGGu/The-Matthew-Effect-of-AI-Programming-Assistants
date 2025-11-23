typedef struct {
    int *data;
    int size;
} Combination;

typedef struct {
    Combination *combinations;
    int size;
} Result;

void backtrack(int *candidates, int candidatesSize, int target, int start, Combination *current, Result *result) {
    if (target == 0) {
        result->combinations[result->size++] = *current;
        return;
    }
    for (int i = start; i < candidatesSize; i++) {
        if (candidates[i] > target) continue;
        current->data[current->size++] = candidates[i];
        backtrack(candidates, candidatesSize, target - candidates[i], i, current, result);
        current->size--;
    }
}

Result combinationSum(int* candidates, int candidatesSize, int target, int* returnSize) {
    Result result;
    result.combinations = malloc(1000 * sizeof(Combination));
    result.size = 0;
    Combination current;
    current.data = malloc(100 * sizeof(int));
    current.size = 0;
    backtrack(candidates, candidatesSize, target, 0, &current, &result);
    free(current.data);
    *returnSize = result.size;
    return result;
}