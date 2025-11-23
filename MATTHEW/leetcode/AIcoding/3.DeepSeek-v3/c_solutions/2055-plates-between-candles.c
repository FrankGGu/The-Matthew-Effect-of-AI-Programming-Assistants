/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* platesBetweenCandles(char * s, int** queries, int queriesSize, int* queriesColSize, int* returnSize){
    int n = strlen(s);
    int *left = malloc(n * sizeof(int));
    int *right = malloc(n * sizeof(int));
    int *prefix = malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        left[i] = -1;
        right[i] = -1;
        prefix[i] = 0;
    }

    int lastCandle = -1;
    for (int i = 0; i < n; i++) {
        if (s[i] == '|') {
            lastCandle = i;
        }
        left[i] = lastCandle;
    }

    lastCandle = -1;
    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == '|') {
            lastCandle = i;
        }
        right[i] = lastCandle;
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '*') {
            count++;
        }
        prefix[i] = count;
    }

    int *result = malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int l = queries[i][0];
        int r = queries[i][1];

        int rightCandle = right[l];
        int leftCandle = left[r];

        if (rightCandle == -1 || leftCandle == -1 || rightCandle >= leftCandle) {
            result[i] = 0;
        } else {
            result[i] = prefix[leftCandle] - prefix[rightCandle];
        }
    }

    free(left);
    free(right);
    free(prefix);

    return result;
}