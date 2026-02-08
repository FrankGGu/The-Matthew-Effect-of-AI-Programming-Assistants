int numSubarrayBoundedMax(int* nums, int numsSize, int left, int right) {
    int count = 0;
    int lessThanLeft = 0;
    int betweenLeftRight = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) {
            count += betweenLeftRight * (betweenLeftRight + 1) / 2;
            count -= lessThanLeft * (lessThanLeft + 1) / 2;
            betweenLeftRight = 0;
            lessThanLeft = 0;
        } else if (nums[i] < left) {
            betweenLeftRight++;
            lessThanLeft++;
        } else { // nums[i] >= left && nums[i] <= right
            count += betweenLeftRight * (betweenLeftRight + 1) / 2;
            count -= lessThanLeft * (lessThanLeft + 1) / 2;
            betweenLeftRight++;
            lessThanLeft = 0;
        }
    }

    count += betweenLeftRight * (betweenLeftRight + 1) / 2;
    count -= lessThanLeft * (lessThanLeft + 1) / 2;

    return count;
}