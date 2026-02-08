public class Solution {
    public int minimumRightShifts(int[] nums) {
        int n = nums.length;
        int minIndex = 0;

        for (int i = 1; i < n; i++) {
            if (nums[i] < nums[minIndex]) {
                minIndex = i;
            }
        }

        for (int i = 0; i < n; i++) {
            if (nums[(minIndex + i) % n] != i + 1) {
                return -1;
            }
        }

        return (n - minIndex) % n;
    }
}