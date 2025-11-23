public class Solution {
    public int minKBitFlips(int[] nums, int k) {
        int n = nums.length;
        int[] flip = new int[n];
        int currentFlips = 0;
        int result = 0;

        for (int i = 0; i < n; i++) {
            currentFlips += flip[i];
            if (nums[i] % 2 == currentFlips % 2) {
                if (i + k > n) return -1;
                result++;
                currentFlips++;
                if (i + 1 < n) flip[i + 1]--;
            }
        }

        return result;
    }
}