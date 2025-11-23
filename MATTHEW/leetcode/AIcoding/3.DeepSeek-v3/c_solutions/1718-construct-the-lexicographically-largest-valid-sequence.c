/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* constructDistancedSequence(int n, int* returnSize) {
    int size = 2 * n - 1;
    *returnSize = size;
    int* result = (int*)calloc(size, sizeof(int));
    int* used = (int*)calloc(n + 1, sizeof(int));

    backtrack(result, used, n, 0);
    free(used);
    return result;
}

int backtrack(int* result, int* used, int n, int index) {
    int size = 2 * n - 1;
    while (index < size && result[index] != 0) {
        index++;
    }
    if (index == size) {
        return 1;
    }

    for (int i = n; i >= 1; i--) {
        if (used[i]) continue;

        if (i == 1) {
            result[index] = 1;
            used[1] = 1;
            if (backtrack(result, used, n, index + 1)) {
                return 1;
            }
            result[index] = 0;
            used[1] = 0;
        } else {
            int secondIndex = index + i;
            if (secondIndex < size && result[secondIndex] == 0) {
                result[index] = i;
                result[secondIndex] = i;
                used[i] = 1;
                if (backtrack(result, used, n, index + 1)) {
                    return 1;
                }
                result[index] = 0;
                result[secondIndex] = 0;
                used[i] = 0;
            }
        }
    }
    return 0;
}