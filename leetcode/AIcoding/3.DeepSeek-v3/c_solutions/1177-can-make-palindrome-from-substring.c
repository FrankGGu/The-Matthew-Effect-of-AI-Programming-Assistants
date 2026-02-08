/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* canMakePaliQueries(char * s, int** queries, int queriesSize, int* queriesColSize, int* returnSize){
    int n = strlen(s);
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    prefix[0] = 0;

    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] ^ (1 << (s[i] - 'a'));
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0];
        int right = queries[i][1];
        int k = queries[i][2];

        int xor_val = prefix[right + 1] ^ prefix[left];
        int odd_count = __builtin_popcount(xor_val);

        if (odd_count / 2 <= k) {
            result[i] = 1;
        } else {
            result[i] = 0;
        }
    }

    free(prefix);
    return result;
}