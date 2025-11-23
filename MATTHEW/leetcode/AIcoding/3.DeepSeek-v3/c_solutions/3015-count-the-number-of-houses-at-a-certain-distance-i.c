/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* countOfPairs(int n, int x, int y, int* returnSize) {
    *returnSize = n;
    int* res = (int*)calloc(n, sizeof(int));

    for (int i = 1; i <= n; i++) {
        for (int j = i + 1; j <= n; j++) {
            int d1 = j - i;
            int d2 = abs(x - i) + 1 + abs(y - j);
            int d3 = abs(y - i) + 1 + abs(x - j);
            int d = d1;
            if (d2 < d) d = d2;
            if (d3 < d) d = d3;
            res[d - 1] += 2;
        }
    }

    return res;
}