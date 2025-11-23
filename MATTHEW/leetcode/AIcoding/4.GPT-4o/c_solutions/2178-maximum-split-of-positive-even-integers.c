#define MAX_SIZE 10000

int* maximumEvenSplit(int finalSum, int* returnSize) {
    if (finalSum % 2 != 0) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(MAX_SIZE * sizeof(int));
    int sum = 0, num = 2, count = 0;

    while (sum + num <= finalSum) {
        result[count++] = num;
        sum += num;
        num += 2;
    }

    if (sum < finalSum) {
        result[count - 1] += (finalSum - sum);
    }

    *returnSize = count;
    return result;
}