public class Solution {
    public String numMovesStonesII(int[] stones) {
        int n = stones.length;
        if (n == 2) {
            return "0";
        }
        java.util.Arrays.sort(stones);
        int left = 0, right = 0;
        int min = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            while (stones[i] - stones[left] >= n) {
                left++;
            }
            if (i - left + 1 == n - 1) {
                min = Math.min(min, 1);
            } else if (i - left + 1 == n - 2) {
                min = Math.min(min, 2);
            }
        }
        int max = Math.max(stones[n - 1] - stones[1], stones[n - 2] - stones[0]) - n + 2;
        return min + "," + max;
    }
}