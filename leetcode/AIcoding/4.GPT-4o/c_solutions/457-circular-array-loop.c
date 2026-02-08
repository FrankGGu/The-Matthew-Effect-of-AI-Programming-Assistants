bool circularArrayLoop(int* nums, int numsSize) {
    for (int i = 0; i < numsSize; i++) {
        int slow = i, fast = i;
        int direction = nums[i] > 0 ? 1 : -1;

        while (1) {
            slow = (slow + nums[slow] + numsSize) % numsSize;
            if (nums[slow] * direction <= 0 || slow == i) break;
            fast = (fast + nums[fast] + numsSize) % numsSize;
            if (nums[fast] * direction <= 0 || fast == i) break;
            fast = (fast + nums[fast] + numsSize) % numsSize;
            if (nums[fast] * direction <= 0 || fast == i) break;
            if (slow == fast) return true;
        }

        int j = i;
        while (nums[j] * direction > 0) {
            int next = (j + nums[j] + numsSize) % numsSize;
            nums[j] = 0;
            j = next;
        }
    }
    return false;
}