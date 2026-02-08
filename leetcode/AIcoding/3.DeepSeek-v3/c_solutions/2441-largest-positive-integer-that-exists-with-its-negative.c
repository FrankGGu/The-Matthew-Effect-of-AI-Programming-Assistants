int findMaxK(int* nums, int numsSize) {
    int maxK = -1;
    int present[2001] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            present[nums[i]] |= 1;
        } else if (nums[i] < 0) {
            present[-nums[i]] |= 2;
        }
    }

    for (int i = 1000; i > 0; i--) {
        if (present[i] == 3) {
            maxK = i;
            break;
        }
    }

    return maxK;
}