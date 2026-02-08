int partitionArray(int* nums, int numsSize, int k){
    if (numsSize == 0) return 0;
    int count = 1;
    int min = nums[0];
    int max = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min) min = nums[i];
        if (nums[i] > max) max = nums[i];

        if (max - min > k) {
            count++;
            min = nums[i];
            max = nums[i];
        }
    }

    return count;
}