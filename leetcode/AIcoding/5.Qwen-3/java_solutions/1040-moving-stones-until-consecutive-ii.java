public class Solution {
    public int numMovesStonesII(int[] stones) {
        int n = stones.length;
        if (n == 2) return 0;
        java.util.Arrays.sort(stones);
        int left = 0, right = 0;
        int min = Integer.MAX_VALUE;
        while (right < n) {
            while (stones[right] - stones[left] >= n) {
                left++;
            }
            if (right - left + 1 == n - 1) {
                min = Math.min(min, 1);
            } else if (right - left + 1 == n - 2) {
                min = Math.min(min, 2);
            }
            right++;
        }
        return Math.min(min, Math.min(stones[n - 1] - stones[1] - n + 2, stones[n - 2] - stones[0] - n + 2));
    }
}