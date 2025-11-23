int* missingRolls(int* rolls, int rollsSize, int mean, int n, int* returnSize) {
    int m = rollsSize;
    int totalSum = mean * (n + m);
    int rollsSum = 0;

    for (int i = 0; i < m; i++) {
        rollsSum += rolls[i];
    }

    int missingSum = totalSum - rollsSum;

    if (missingSum < n || missingSum > 6 * n) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int base = missingSum / n;
    int remainder = missingSum % n;

    for (int i = 0; i < n; i++) {
        result[i] = base + (i < remainder ? 1 : 0);
    }

    return result;
}