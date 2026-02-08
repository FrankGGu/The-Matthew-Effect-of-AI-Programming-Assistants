/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* shortestSeq(int* big, int bigSize, int* small, int smallSize, int* returnSize) {
    int *result = malloc(2 * sizeof(int));
    *returnSize = 0;

    if (bigSize < smallSize) {
        return result;
    }

    int need[100001] = {0};
    int window[100001] = {0};
    int required = 0;

    for (int i = 0; i < smallSize; i++) {
        if (need[small[i]] == 0) {
            required++;
        }
        need[small[i]]++;
    }

    int left = 0, right = 0;
    int formed = 0;
    int minLen = INT_MAX;
    int start = -1;

    while (right < bigSize) {
        int num = big[right];
        window[num]++;

        if (need[num] > 0 && window[num] == need[num]) {
            formed++;
        }

        while (left <= right && formed == required) {
            int currentLen = right - left + 1;
            if (currentLen < minLen) {
                minLen = currentLen;
                start = left;
            }

            int leftNum = big[left];
            window[leftNum]--;
            if (need[leftNum] > 0 && window[leftNum] < need[leftNum]) {
                formed--;
            }
            left++;
        }
        right++;
    }

    if (start == -1) {
        return result;
    }

    result[0] = start;
    result[1] = start + minLen - 1;
    *returnSize = 2;
    return result;
}