public class Solution {
    public int waysToMakeFair(int[] nums) {
        int n = nums.length;
        int total = 0;
        for (int i = 0; i < n; i++) {
            int left = 0;
            int right = 0;
            for (int j = 0; j < i; j++) {
                if (j % 2 == 0) {
                    left += nums[j];
                } else {
                    right += nums[j];
                }
            }
            for (int j = i + 1; j < n; j++) {
                if ((j - i - 1) % 2 == 0) {
                    left += nums[j];
                } else {
                    right += nums[j];
                }
            }
            if (left == right) {
                total++;
            }
        }
        return total;
    }
}