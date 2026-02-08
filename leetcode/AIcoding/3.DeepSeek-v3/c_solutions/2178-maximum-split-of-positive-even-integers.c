/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
long long* maximumEvenSplit(long long finalSum, int* returnSize) {
    if (finalSum % 2 != 0) {
        *returnSize = 0;
        return NULL;
    }

    long long sum = 0;
    long long num = 2;
    int count = 0;

    while (sum + num <= finalSum) {
        sum += num;
        num += 2;
        count++;
    }

    long long* result = (long long*)malloc(count * sizeof(long long));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < count - 1; i++) {
        result[i] = 2LL * (i + 1);
    }
    result[count - 1] = finalSum - (sum - 2LL * count);

    *returnSize = count;
    return result;
}