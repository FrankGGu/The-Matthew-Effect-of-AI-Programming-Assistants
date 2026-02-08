int* goodDaysToRobBank(int* security, int securitySize, int* returnSize) {
    int* result = (int*)malloc(securitySize * sizeof(int));
    int count = 0, nonIncreasing = 0;

    for (int i = securitySize - 1; i > 0; i--) {
        if (security[i] <= security[i - 1]) {
            nonIncreasing++;
        } else {
            nonIncreasing = 0;
        }

        if (nonIncreasing >= securitySize - 1) {
            result[count++] = i - 1;
        }
    }

    *returnSize = count;
    int* finalResult = (int*)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        finalResult[i] = result[count - 1 - i];
    }

    free(result);
    return finalResult;
}