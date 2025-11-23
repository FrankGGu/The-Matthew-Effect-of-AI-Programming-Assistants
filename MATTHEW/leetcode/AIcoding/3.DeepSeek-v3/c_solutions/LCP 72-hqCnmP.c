int* supplyWagon(int* supplies, int suppliesSize, int* returnSize) {
    int n = suppliesSize;
    int target = n / 2;
    int* result = (int*)malloc(target * sizeof(int));

    while (n > target) {
        int minSum = INT_MAX;
        int mergeIndex = 0;

        for (int i = 0; i < n - 1; i++) {
            int sum = supplies[i] + supplies[i + 1];
            if (sum < minSum) {
                minSum = sum;
                mergeIndex = i;
            }
        }

        supplies[mergeIndex] = minSum;
        for (int i = mergeIndex + 1; i < n - 1; i++) {
            supplies[i] = supplies[i + 1];
        }
        n--;
    }

    for (int i = 0; i < target; i++) {
        result[i] = supplies[i];
    }

    *returnSize = target;
    return result;
}