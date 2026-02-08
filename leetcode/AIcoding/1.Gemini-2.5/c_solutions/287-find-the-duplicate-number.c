int findDuplicate(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return -1; // Or handle error as appropriate, problem constraints say n >= 2
    }

    int slow = nums[0];
    int fast = nums[nums[0]];

    while (slow != fast) {
        slow = nums[slow];
        fast = nums[nums[fast]];
    }

    fast = 0;
    while (slow != fast) {
        slow = nums[slow];
        fast = nums[fast];
    }

    return slow;
}