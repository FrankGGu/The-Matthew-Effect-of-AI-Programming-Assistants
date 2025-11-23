char* optimalDivision(int* nums, int numsSize) {
    if (numsSize == 1) {
        char* result = (char*)malloc(20 * sizeof(char));
        sprintf(result, "%d", nums[0]);
        return result;
    }

    char* result = (char*)malloc(100 * sizeof(char));
    if (numsSize == 2) {
        sprintf(result, "%d/%d", nums[0], nums[1]);
    } else {
        sprintf(result, "%d/(%d", nums[0], nums[1]);
        for (int i = 2; i < numsSize; i++) {
            sprintf(result + strlen(result), "/%d", nums[i]);
        }
        sprintf(result + strlen(result), ")");
    }

    return result;
}