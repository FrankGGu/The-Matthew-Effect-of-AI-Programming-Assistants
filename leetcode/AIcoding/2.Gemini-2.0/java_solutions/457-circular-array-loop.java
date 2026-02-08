class Solution {
    public boolean circularArrayLoop(int[] nums) {
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            if (nums[i] == 0) continue;
            int slow = i, fast = i;
            boolean positive = nums[i] > 0;
            while (true) {
                slow = next(nums, slow);
                if (nums[slow] > 0 != positive) break;
                fast = next(nums, fast);
                if (nums[fast] > 0 != positive) break;
                fast = next(nums, fast);
                if (nums[fast] > 0 != positive) break;
                if (slow == fast) {
                    if (slow == next(nums, slow)) break;
                    return true;
                }
            }
            slow = i;
            int val = nums[i];
            while (nums[slow] * val > 0) {
                int next = next(nums, slow);
                nums[slow] = 0;
                slow = next;
            }
        }
        return false;
    }

    private int next(int[] nums, int i) {
        int n = nums.length;
        return ((i + nums[i]) % n + n) % n;
    }
}