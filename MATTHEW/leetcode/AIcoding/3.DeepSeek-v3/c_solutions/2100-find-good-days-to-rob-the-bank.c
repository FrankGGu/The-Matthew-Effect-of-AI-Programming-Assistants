int* goodDaysToRobBank(int* security, int securitySize, int time, int* returnSize) {
    if (securitySize < 2 * time + 1) {
        *returnSize = 0;
        return NULL;
    }

    int* left = (int*)malloc(securitySize * sizeof(int));
    int* right = (int*)malloc(securitySize * sizeof(int));
    int* result = (int*)malloc(securitySize * sizeof(int));

    left[0] = 0;
    for (int i = 1; i < securitySize; i++) {
        if (security[i] <= security[i-1]) {
            left[i] = left[i-1] + 1;
        } else {
            left[i] = 0;
        }
    }

    right[securitySize-1] = 0;
    for (int i = securitySize-2; i >= 0; i--) {
        if (security[i] <= security[i+1]) {
            right[i] = right[i+1] + 1;
        } else {
            right[i] = 0;
        }
    }

    int count = 0;
    for (int i = time; i < securitySize - time; i++) {
        if (left[i] >= time && right[i] >= time) {
            result[count++] = i;
        }
    }

    free(left);
    free(right);

    *returnSize = count;
    return result;
}