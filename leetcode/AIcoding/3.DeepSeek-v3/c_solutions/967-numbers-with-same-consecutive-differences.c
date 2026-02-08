/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* numsSameConsecDiff(int n, int k, int* returnSize) {
    if (n == 1) {
        *returnSize = 10;
        int* result = malloc(10 * sizeof(int));
        for (int i = 0; i < 10; i++) {
            result[i] = i;
        }
        return result;
    }

    int queue[10000];
    int front = 0, rear = 0;

    for (int i = 1; i <= 9; i++) {
        queue[rear++] = i;
    }

    for (int level = 1; level < n; level++) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int num = queue[front++];
            int last_digit = num % 10;

            if (last_digit + k <= 9) {
                queue[rear++] = num * 10 + (last_digit + k);
            }

            if (k != 0 && last_digit - k >= 0) {
                queue[rear++] = num * 10 + (last_digit - k);
            }
        }
    }

    *returnSize = rear - front;
    int* result = malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = queue[front + i];
    }

    return result;
}