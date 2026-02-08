class Solution {
    public boolean circularArrayLoop(int[] nums) {
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            if (nums[i] == 0) {
                continue;
            }
            int slow = i, fast = getNext(nums, i);
            while (nums[slow] * nums[fast] > 0 && nums[slow] * nums[getNext(nums, fast)] > 0) {
                if (slow == fast) {
                    if (slow == getNext(nums, slow)) {
                        break;
                    }
                    return true;
                }
                slow = getNext(nums, slow);
                fast = getNext(nums, getNext(nums, fast));
            }
            int j = i;
            while (nums[j] * nums[getNext(nums, j)] > 0) {
                int next = getNext(nums, j);
                nums[j] = 0;
                j = next;
            }
        }
        return false;
    }

    private int getNext(int[] nums, int i) {
        int n = nums.length;
        return ((i + nums[i]) % n + n) % n;
    }
}