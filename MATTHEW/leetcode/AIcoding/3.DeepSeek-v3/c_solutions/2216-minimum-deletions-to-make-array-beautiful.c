int minDeletion(int* nums, int numsSize) {
    int deletions = 0;
    int i = 0;

    while (i < numsSize) {
        int j = i + 1;
        while (j < numsSize && nums[j] == nums[i]) {
            deletions++;
            j++;
        }
        if (j >= numsSize) {
            deletions++;
            break;
        }
        i = j + 1;
    }

    return deletions;
}