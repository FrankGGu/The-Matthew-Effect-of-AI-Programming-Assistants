/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* sequentialDigits(int low, int high, int* returnSize) {
    int results[100];
    int count = 0;

    for (int start = 1; start <= 9; start++) {
        int num = start;
        for (int next = start + 1; next <= 9; next++) {
            num = num * 10 + next;
            if (num >= low && num <= high) {
                results[count++] = num;
            }
            if (num > high) break;
        }
    }

    for (int i = 0; i < count - 1; i++) {
        for (int j = 0; j < count - i - 1; j++) {
            if (results[j] > results[j + 1]) {
                int temp = results[j];
                results[j] = results[j + 1];
                results[j + 1] = temp;
            }
        }
    }

    *returnSize = count;
    int* ans = (int*)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        ans[i] = results[i];
    }
    return ans;
}