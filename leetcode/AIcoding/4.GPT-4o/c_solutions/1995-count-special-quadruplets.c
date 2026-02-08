int countQuadruplets(int* nums, int numsSize) {
    int count = 0;
    for (int a = 0; a < numsSize - 3; a++) {
        for (int b = a + 1; b < numsSize - 2; b++) {
            for (int c = b + 1; c < numsSize - 1; c++) {
                for (int d = c + 1; d < numsSize; d++) {
                    if (nums[a] + nums[b] + nums[c] == nums[d]) {
                        count++;
                    }
                }
            }
        }
    }
    return count;
}