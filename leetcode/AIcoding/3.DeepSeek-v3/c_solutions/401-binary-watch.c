/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** readBinaryWatch(int turnedOn, int* returnSize){
    char **result = malloc(1000 * sizeof(char *));
    *returnSize = 0;

    for (int h = 0; h < 12; h++) {
        for (int m = 0; m < 60; m++) {
            if (__builtin_popcount(h) + __builtin_popcount(m) == turnedOn) {
                char *time = malloc(6 * sizeof(char));
                sprintf(time, "%d:%02d", h, m);
                result[(*returnSize)++] = time;
            }
        }
    }

    return result;
}