char* findDifferentBinaryString(char** nums, int numsSize) {
    char* res = (char*)malloc((numsSize + 1) * sizeof(char));
    res[numsSize] = '\0';

    for (int i = 0; i < numsSize; i++) {
        res[i] = nums[i][i] == '0' ? '1' : '0';
    }

    return res;
}