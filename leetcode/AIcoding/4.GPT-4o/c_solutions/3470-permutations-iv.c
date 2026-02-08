#define MAX_N 10

void backtrack(int* nums, int numsSize, bool* visited, int* path, int pathSize, int** res, int* returnSize, int** returnColumnSizes) {
    if (pathSize == numsSize) {
        res[*returnSize] = (int*)malloc(sizeof(int) * numsSize);
        memcpy(res[*returnSize], path, sizeof(int) * numsSize);
        returnColumnSizes[0][*returnSize] = numsSize;
        (*returnSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (visited[i]) continue;
        if (i > 0 && nums[i] == nums[i - 1] && !visited[i - 1]) continue;

        visited[i] = true;
        path[pathSize] = nums[i];
        backtrack(nums, numsSize, visited, path, pathSize + 1, res, returnSize, returnColumnSizes);
        visited[i] = false;
    }
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    int** res = (int**)malloc(sizeof(int*) * 40320); // 10! = 362880, just a safe upper limit
    *returnColumnSizes = (int*)malloc(sizeof(int) * 40320);
    bool visited[MAX_N] = {false};
    int path[MAX_N];

    qsort(nums, numsSize, sizeof(int), (int(*)(const void*, const void*))compare);
    backtrack(nums, numsSize, visited, path, 0, res, returnSize, returnColumnSizes);

    return res;
}

int compare(const int* a, const int* b) {
    return *a - *b;
}