/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
long long* countOfPairs(int n, int x, int y, int* returnSize) {
    *returnSize = n;
    long long* res = (long long*)calloc(n, sizeof(long long));
    if (x > y) {
        int temp = x;
        x = y;
        y = temp;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = i + 1; j <= n; j++) {
            int d1 = j - i;
            int d2 = abs(i - x) + 1 + abs(j - y);
            int d3 = abs(i - y) + 1 + abs(j - x);
            int d = d1;
            if (d2 < d) d = d2;
            if (d3 < d) d = d3;
            if (d > 0 && d <= n) {
                res[d - 1] += 2;
            }
        }
    }

    return res;
}