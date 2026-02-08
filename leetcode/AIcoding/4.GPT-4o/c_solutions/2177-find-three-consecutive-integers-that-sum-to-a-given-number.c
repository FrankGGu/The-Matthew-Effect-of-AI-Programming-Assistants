int* sumOfThree(int num, int* returnSize) {
    *returnSize = 0;
    int* result = malloc(3 * sizeof(int));

    if (num % 3 == 0) {
        result[0] = num / 3 - 1;
        result[1] = num / 3;
        result[2] = num / 3 + 1;
        *returnSize = 3;
    } else if (num % 3 == 1) {
        result[0] = num / 3;
        result[1] = num / 3 + 1;
        result[2] = num / 3 + 2;
        *returnSize = 3;
    } else if (num % 3 == 2) {
        result[0] = num / 3 - 1;
        result[1] = num / 3;
        result[2] = num / 3 + 1;
        *returnSize = 3;
    }

    if (*returnSize == 0) {
        free(result);
        return NULL;
    }

    return result;
}