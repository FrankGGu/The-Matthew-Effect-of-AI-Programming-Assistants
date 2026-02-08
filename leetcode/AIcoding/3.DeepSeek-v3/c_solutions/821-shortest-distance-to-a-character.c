/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* shortestToChar(char* s, char c, int* returnSize) {
    int n = strlen(s);
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int prev = -n;

    for (int i = 0; i < n; i++) {
        if (s[i] == c) {
            prev = i;
        }
        result[i] = i - prev;
    }

    prev = 2 * n;
    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == c) {
            prev = i;
        }
        result[i] = (result[i] < prev - i) ? result[i] : (prev - i);
    }

    return result;
}