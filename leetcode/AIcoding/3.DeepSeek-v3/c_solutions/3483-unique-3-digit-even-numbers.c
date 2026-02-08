/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findEvenNumbers(int* digits, int digitsSize, int* returnSize) {
    int count[10] = {0};
    for (int i = 0; i < digitsSize; i++) {
        count[digits[i]]++;
    }

    int* result = malloc(1000 * sizeof(int));
    int idx = 0;

    for (int i = 1; i <= 9; i++) {
        if (count[i] == 0) continue;
        count[i]--;
        for (int j = 0; j <= 9; j++) {
            if (count[j] == 0) continue;
            count[j]--;
            for (int k = 0; k <= 8; k += 2) {
                if (count[k] == 0) continue;
                result[idx++] = i * 100 + j * 10 + k;
            }
            count[j]++;
        }
        count[i]++;
    }

    *returnSize = idx;
    return result;
}