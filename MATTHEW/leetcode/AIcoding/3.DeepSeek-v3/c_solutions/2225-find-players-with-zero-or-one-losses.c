/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the two arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** findWinners(int** matches, int matchesSize, int* matchesColSize, int* returnSize, int** returnColumnSizes) {
    int max_id = 0;
    for (int i = 0; i < matchesSize; i++) {
        if (matches[i][0] > max_id) max_id = matches[i][0];
        if (matches[i][1] > max_id) max_id = matches[i][1];
    }

    int* losses = calloc(max_id + 1, sizeof(int));
    int* played = calloc(max_id + 1, sizeof(int));

    for (int i = 0; i < matchesSize; i++) {
        int winner = matches[i][0];
        int loser = matches[i][1];
        played[winner] = 1;
        played[loser] = 1;
        losses[loser]++;
    }

    int** result = malloc(2 * sizeof(int*));
    *returnColumnSizes = malloc(2 * sizeof(int));

    int count0 = 0, count1 = 0;
    for (int i = 1; i <= max_id; i++) {
        if (played[i]) {
            if (losses[i] == 0) count0++;
            else if (losses[i] == 1) count1++;
        }
    }

    result[0] = malloc(count0 * sizeof(int));
    result[1] = malloc(count1 * sizeof(int));
    (*returnColumnSizes)[0] = count0;
    (*returnColumnSizes)[1] = count1;

    int idx0 = 0, idx1 = 0;
    for (int i = 1; i <= max_id; i++) {
        if (played[i]) {
            if (losses[i] == 0) result[0][idx0++] = i;
            else if (losses[i] == 1) result[1][idx1++] = i;
        }
    }

    free(losses);
    free(played);

    *returnSize = 2;
    return result;
}