class Solution {
    public int maxScore(int[] nums, int x) {
        long even = Integer.MIN_VALUE;
        long odd = Integer.MIN_VALUE;

        for (int num : nums) {
            if (num % 2 == 0) {
                if (even == Integer.MIN_VALUE) {
                    even = (long) num;
                } else {
                    even = Math.max(even + num, odd + num - x);
                }
            } else {
                if (odd == Integer.MIN_VALUE) {
                    odd = (long) num;
                } else {
                    odd = Math.max(odd + num, even + num - x);
                }
            }
        }

        if (nums[0] % 2 == 0) {
            return (int) even;
        } else {
            return (int) odd;
        }
    }
}