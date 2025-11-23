int arrayNesting(int* nums, int numsSize) {
    int max = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != -1) {
            int count = 0;
            int current = i;
            while (nums[current] != -1) {
                count++;
                int next = nums[current];
                nums[current] = -1;
                current = next;
            }
            if (count > max) {
                max = count;
            }
        }
    }
    return max;
}