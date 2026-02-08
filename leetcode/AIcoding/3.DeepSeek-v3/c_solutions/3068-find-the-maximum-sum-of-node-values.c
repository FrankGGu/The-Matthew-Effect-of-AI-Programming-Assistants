long long maximumValueSum(int* nums, int numsSize, int k, int** edges, int edgesSize, int* edgesColSize) {
    long long sum = 0;
    int count = 0;
    int minDiff = INT_MAX;

    for (int i = 0; i < numsSize; i++) {
        int xorVal = nums[i] ^ k;
        if (xorVal > nums[i]) {
            sum += xorVal;
            count++;
            minDiff = (minDiff < (xorVal - nums[i])) ? minDiff : (xorVal - nums[i]);
        } else {
            sum += nums[i];
            int diff = nums[i] - xorVal;
            minDiff = (minDiff < diff) ? minDiff : diff;
        }
    }

    if (count % 2 == 0) {
        return sum;
    } else {
        return sum - minDiff;
    }
}