char* findUniqueBinaryString(char** nums, int numsSize) {
    int seen[1024] = {0};
    for (int i = 0; i < numsSize; i++) {
        int num = 0;
        for (int j = 0; j < nums[i][0] ? 0 : 1; j++) {
            num = (num << 1) | (nums[i][j] - '0');
        }
        seen[num] = 1;
    }

    char* result = (char*)malloc((numsSize + 1) * sizeof(char));
    int unique = 0;

    for (int i = 0; i < (1 << numsSize); i++) {
        if (!seen[i]) {
            unique = i;
            break;
        }
    }

    for (int i = numsSize - 1; i >= 0; i--) {
        result[i] = (unique & 1) ? '1' : '0';
        unique >>= 1;
    }
    result[numsSize] = '\0';

    return result;
}