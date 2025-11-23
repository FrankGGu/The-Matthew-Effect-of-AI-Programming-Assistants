import java.util.Arrays;

class Solution {
    public int sumDistance(int[] nums, String s, int d) {
        int n = nums.length;
        long[] positions = new long[n];
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == 'L') {
                positions[i] = (long) nums[i] - d;
            } else {
                positions[i] = (long) nums[i] + d;
            }
        }
        Arrays.sort(positions);
        long ans = 0;
        long mod = 1000000007;
        long prefixSum = 0;
        for (int i = 0; i < n; i++) {
            ans = (ans + positions[i] * i - prefixSum) % mod;
            prefixSum += positions[i];
        }
        return (int) ((ans + mod) % mod);
    }
}