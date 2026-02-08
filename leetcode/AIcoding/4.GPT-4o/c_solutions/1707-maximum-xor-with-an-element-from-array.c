int maximumXOR(int* nums, int numsSize, int* queries, int queriesSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        maxNum = (nums[i] > maxNum) ? nums[i] : maxNum;
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        result[i] = maxNum ^ queries[i];
    }

    return result;
}