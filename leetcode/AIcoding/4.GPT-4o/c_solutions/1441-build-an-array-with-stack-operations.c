char **buildArray(int* target, int targetSize, int* returnSize) {
    int maxNum = target[targetSize - 1];
    char **result = malloc(sizeof(char*) * (2 * targetSize));
    *returnSize = 0;

    for (int i = 1, j = 0; i <= maxNum; i++) {
        result[(*returnSize)++] = "Push";
        if (j < targetSize && target[j] == i) {
            j++;
        } else {
            result[(*returnSize)++] = "Pop";
        }
    }

    return result;
}