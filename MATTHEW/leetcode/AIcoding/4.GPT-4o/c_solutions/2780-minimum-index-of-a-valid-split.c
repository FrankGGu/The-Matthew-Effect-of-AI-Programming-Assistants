int minimumIndex(int* nums, int numsSize) {
    int count = 0, target = -1, total = 0;

    for (int i = 0; i < numsSize; i++) {
        if (count == 0) {
            target = nums[i];
            count = 1;
        } else if (nums[i] == target) {
            count++;
        } else {
            count--;
        }
    }

    if (count == 0) return -1;

    count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            count++;
        }
    }

    total = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            total++;
        }
        if (total * 2 > count && i + 1 < numsSize) {
            return i;
        }
    }

    return -1;
}