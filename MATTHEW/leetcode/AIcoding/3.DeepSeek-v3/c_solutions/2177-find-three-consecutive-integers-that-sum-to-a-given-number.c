long long* sumOfThree(long long num, int* returnSize) {
    long long *result = malloc(3 * sizeof(long long));
    *returnSize = 0;

    if (num % 3 != 0) {
        return result;
    }

    long long mid = num / 3;
    result[0] = mid - 1;
    result[1] = mid;
    result[2] = mid + 1;
    *returnSize = 3;

    return result;
}