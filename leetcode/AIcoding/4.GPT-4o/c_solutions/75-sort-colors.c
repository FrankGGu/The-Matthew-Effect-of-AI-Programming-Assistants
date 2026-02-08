void sortColors(int* nums, int numsSize) {
    int count[3] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }
    for (int i = 0, index = 0; i < 3; i++) {
        while (count[i]-- > 0) {
            nums[index++] = i;
        }
    }
}