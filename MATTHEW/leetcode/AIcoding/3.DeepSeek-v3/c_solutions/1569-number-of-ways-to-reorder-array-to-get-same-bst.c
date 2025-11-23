/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

long long mod = 1000000007;
long long** table;

long long dfs(int* nums, int numsSize) {
    if (numsSize <= 2) return 1;
    int leftSize = 0, rightSize = 0;
    int* left = (int*)malloc(sizeof(int) * numsSize);
    int* right = (int*)malloc(sizeof(int) * numsSize);

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[0]) {
            left[leftSize++] = nums[i];
        } else {
            right[rightSize++] = nums[i];
        }
    }

    long long leftWays = dfs(left, leftSize) % mod;
    long long rightWays = dfs(right, rightSize) % mod;

    free(left);
    free(right);

    return (((table[numsSize - 1][leftSize] * leftWays) % mod) * rightWays) % mod;
}

int numOfWays(int* nums, int numsSize) {
    table = (long long**)malloc(sizeof(long long*) * (numsSize + 1));
    for (int i = 0; i <= numsSize; i++) {
        table[i] = (long long*)malloc(sizeof(long long) * (i + 1));
        table[i][0] = table[i][i] = 1;
        for (int j = 1; j < i; j++) {
            table[i][j] = (table[i-1][j-1] + table[i-1][j]) % mod;
        }
    }

    long long result = (dfs(nums, numsSize) - 1) % mod;

    for (int i = 0; i <= numsSize; i++) {
        free(table[i]);
    }
    free(table);

    return (int)result;
}