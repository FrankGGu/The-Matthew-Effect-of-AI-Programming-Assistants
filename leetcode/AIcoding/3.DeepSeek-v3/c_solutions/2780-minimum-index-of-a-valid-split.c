int minimumIndex(int* nums, int numsSize) {
    int candidate = -1, count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (count == 0) {
            candidate = nums[i];
            count = 1;
        } else if (nums[i] == candidate) {
            count++;
        } else {
            count--;
        }
    }

    count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == candidate) {
            count++;
        }
    }

    int leftCount = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] == candidate) {
            leftCount++;
        }
        int leftSize = i + 1;
        int rightSize = numsSize - leftSize;
        int rightCount = count - leftCount;

        if (leftCount * 2 > leftSize && rightCount * 2 > rightSize) {
            return i;
        }
    }

    return -1;
}