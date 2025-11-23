/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* solve(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = numsSize;
    int* res = malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int max_val = 0;
    for (int i = 0; i < n; i++) {
        if (nums[i] > max_val) max_val = nums[i];
    }

    int* cnt = calloc(max_val + 1, sizeof(int));
    for (int i = 0; i < n; i++) {
        cnt[nums[i]]++;
    }

    int* f = calloc(max_val + 1, sizeof(int));
    for (int i = 1; i <= max_val; i++) {
        for (int j = i; j <= max_val; j += i) {
            f[i] += cnt[j];
        }
    }

    int* g = calloc(max_val + 1, sizeof(int));
    for (int i = max_val; i >= 1; i--) {
        g[i] = f[i] * (f[i] - 1) / 2;
        for (int j = 2 * i; j <= max_val; j += i) {
            g[i] -= g[j];
        }
    }

    for (int i = 0; i < queriesSize; i++) {
        int k = queries[i][0];
        int idx = 0;
        for (int d = max_val; d >= 1; d--) {
            if (g[d] > k) {
                idx = d;
                break;
            }
            k -= g[d];
        }
        res[i] = idx;
    }

    free(cnt);
    free(f);
    free(g);
    return res;
}