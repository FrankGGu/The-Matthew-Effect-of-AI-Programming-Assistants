/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* relocateMarbles(int* nums, int numsSize, int* moveFrom, int moveFromSize, int* moveTo, int moveToSize, int* returnSize) {
    int pos[100001] = {0};
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (pos[nums[i]] == 0) {
            count++;
            pos[nums[i]] = 1;
        }
    }

    for (int i = 0; i < moveFromSize; i++) {
        if (pos[moveFrom[i]] == 1) {
            pos[moveFrom[i]] = 0;
            count--;
            if (pos[moveTo[i]] == 0) {
                pos[moveTo[i]] = 1;
                count++;
            }
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    int idx = 0;
    for (int i = 0; i < 100001; i++) {
        if (pos[i] == 1) {
            result[idx++] = i;
        }
    }

    *returnSize = count;
    return result;
}