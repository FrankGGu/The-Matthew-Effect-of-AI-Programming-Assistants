class Solution {
    public int solve(int[] nums) {
        int n = nums.length;
        if (n < 2) {
            return 0;
        }

        int count = 0;
        int len = 1;
        for (int i = 1; i < n; i++) {
            if (nums[i] > nums[i - 1]) {
                len++;
            } else {
                if (len >= 3) {
                    count++;
                }
                len = 1;
            }
        }

        if (len >= 3) {
            count++;
        }

        return count;
    }
}