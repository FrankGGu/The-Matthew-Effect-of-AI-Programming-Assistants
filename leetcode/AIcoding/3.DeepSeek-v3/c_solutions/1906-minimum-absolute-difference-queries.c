/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* minDifference(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int prefix[100001][101] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (i > 0) {
            for (int j = 1; j <= 100; j++) {
                prefix[i][j] = prefix[i-1][j];
            }
        }
        prefix[i][nums[i]]++;
    }

    int* result = malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0];
        int right = queries[i][1];

        int count[101] = {0};
        if (left == 0) {
            for (int j = 1; j <= 100; j++) {
                count[j] = prefix[right][j];
            }
        } else {
            for (int j = 1; j <= 100; j++) {
                count[j] = prefix[right][j] - prefix[left-1][j];
            }
        }

        int minDiff = INT_MAX;
        int prev = -1;
        for (int j = 1; j <= 100; j++) {
            if (count[j] > 0) {
                if (prev != -1) {
                    int diff = j - prev;
                    if (diff < minDiff) {
                        minDiff = diff;
                    }
                }
                prev = j;
            }
        }

        result[i] = (minDiff == INT_MAX) ? -1 : minDiff;
    }

    return result;
}