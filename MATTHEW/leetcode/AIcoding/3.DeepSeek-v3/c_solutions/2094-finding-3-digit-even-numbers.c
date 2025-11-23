/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findEvenNumbers(int* digits, int digitsSize, int* returnSize) {
    int freq[10] = {0};
    for (int i = 0; i < digitsSize; i++) {
        freq[digits[i]]++;
    }

    int* result = malloc(1000 * sizeof(int));
    int count = 0;

    for (int i = 100; i <= 998; i += 2) {
        int tempFreq[10] = {0};
        int num = i;
        while (num > 0) {
            tempFreq[num % 10]++;
            num /= 10;
        }

        int valid = 1;
        for (int j = 0; j < 10; j++) {
            if (tempFreq[j] > freq[j]) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}