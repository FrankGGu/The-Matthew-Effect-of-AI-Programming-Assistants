int countSpecialQuadruplets(int* nums, int numsSize) {
    int count = 0;
    for (int d = 3; d < numsSize; d++) {
        for (int c = 2; c < d; c++) {
            for (int b = 1; b < c; b++) {
                for (int a = 0; a < b; a++) {
                    if (nums[a] + nums[b] + nums[c] == nums[d]) {
                        count++;
                    }
                }
            }
        }
    }
    return count;
}