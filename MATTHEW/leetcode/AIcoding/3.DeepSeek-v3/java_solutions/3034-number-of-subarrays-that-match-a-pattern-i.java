class Solution {
    public int countMatchingSubarrays(int[] nums, int[] pattern) {
        int count = 0;
        int n = nums.length;
        int m = pattern.length;

        for (int i = 0; i <= n - m - 1; i++) {
            boolean match = true;
            for (int j = 0; j < m; j++) {
                int num1 = nums[i + j];
                int num2 = nums[i + j + 1];
                int expected = pattern[j];
                int actual;
                if (num1 < num2) {
                    actual = 1;
                } else if (num1 == num2) {
                    actual = 0;
                } else {
                    actual = -1;
                }
                if (actual != expected) {
                    match = false;
                    break;
                }
            }
            if (match) {
                count++;
            }
        }
        return count;
    }
}