/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* splitIntoFibonacci(char* num, int* returnSize) {
    int n = strlen(num);
    *returnSize = 0;
    if (n < 3) return NULL;

    int* result = (int*)malloc(sizeof(int) * n);
    if (!result) return NULL;

    for (int i = 1; i <= 10 && i < n; i++) {
        if (num[0] == '0' && i > 1) break;

        long long first = 0;
        for (int k = 0; k < i; k++) {
            first = first * 10 + (num[k] - '0');
        }
        if (first > INT_MAX) break;

        for (int j = 1; j <= 10 && i + j < n; j++) {
            if (num[i] == '0' && j > 1) break;

            long long second = 0;
            for (int k = i; k < i + j; k++) {
                second = second * 10 + (num[k] - '0');
            }
            if (second > INT_MAX) break;

            result[0] = (int)first;
            result[1] = (int)second;
            int pos = 2;
            int start = i + j;

            long long prev1 = first;
            long long prev2 = second;
            long long current = 0;

            int idx = start;
            while (idx < n) {
                current = 0;
                int len = 0;
                while (idx < n && current < prev1 + prev2) {
                    current = current * 10 + (num[idx] - '0');
                    idx++;
                    len++;
                }

                if (current != prev1 + prev2 || current > INT_MAX) {
                    break;
                }

                result[pos++] = (int)current;
                prev1 = prev2;
                prev2 = current;

                if (idx == n) {
                    *returnSize = pos;
                    return result;
                }
            }
        }
    }

    free(result);
    *returnSize = 0;
    return NULL;
}