bool circularArrayLoop(int* nums, int numsSize) {
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) continue;

        int slow = i, fast = i;
        int dir = nums[i] > 0;

        do {
            slow = getNext(nums, numsSize, slow, dir);
            fast = getNext(nums, numsSize, fast, dir);
            if (fast != -1) fast = getNext(nums, numsSize, fast, dir);
        } while (slow != -1 && fast != -1 && slow != fast);

        if (slow != -1 && fast != -1 && slow == fast) {
            return true;
        }

        slow = i;
        int val = nums[i];
        while (nums[slow] * val > 0) {
            int next = getNext(nums, numsSize, slow, dir);
            nums[slow] = 0;
            slow = next;
        }
    }
    return false;
}

int getNext(int* nums, int numsSize, int index, int dir) {
    int next = ((index + nums[index]) % numsSize + numsSize) % numsSize;
    if (next == index) return -1;
    if ((nums[next] > 0) != dir) return -1;
    return next;
}