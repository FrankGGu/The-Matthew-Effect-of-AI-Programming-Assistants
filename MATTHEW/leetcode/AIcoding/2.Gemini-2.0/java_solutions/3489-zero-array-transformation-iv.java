class Solution {
    public boolean solve(int[] nums) {
        int n = nums.length;
        int xor = 0;
        for (int num : nums) {
            xor ^= num;
        }

        if (xor != 0) {
            return false;
        }

        if (n % 2 == 0) {
            return true;
        } else {
            return false;
        }
    }
}