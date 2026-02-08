int wiggleMaxLength(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return 1;
    }

    int count = 1;
    int prevDiff = 0; 

    for (int i = 1; i < numsSize; i++) {
        int currDiff = nums[i] - nums[i-1];

        if (currDiff > 0 && prevDiff <= 0) {
            count++;
            prevDiff = currDiff;
        } else if (currDiff < 0 && prevDiff >= 0) {
            count++;
            prevDiff = currDiff;
        }
    }

    return count;
}