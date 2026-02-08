typedef struct {
    int *data;
    int size;
} Combination;

typedef struct {
    Combination *combinations;
    int size;
    int capacity;
} Result;

void backtrack(int *candidates, int candidatesSize, int target, int start, Combination *current, Result *result) {
    if (target == 0) {
        if (result->size == result->capacity) {
            result->capacity = result->capacity == 0 ? 1 : result->capacity * 2;
            result->combinations = realloc(result->combinations, result->capacity * sizeof(Combination));
        }
        result->combinations[result->size] = *current;
        result->size++;
        return;
    }
    for (int i = start; i < candidatesSize; i++) {
        if (candidates[i] > target) continue;
        current->data[current->size++] = candidates[i];
        backtrack(candidates, candidatesSize, target - candidates[i], i, current, result);
        current->size--;
    }
}

Result combinationSum(int *candidates, int candidatesSize, int target, int *returnSize) {
    Result result;
    result.size = 0;
    result.capacity = 0;
    result.combinations = NULL;

    Combination current;
    current.data = malloc(100 * sizeof(int)); // Adjust size as necessary
    current.size = 0;

    backtrack(candidates, candidatesSize, target, 0, &current, &result);

    free(current.data);

    *returnSize = result.size;
    return result;
}