class Solution {
    public int sumDistance(int[] nums, String s, int d) {
        int n = nums.length;
        long[] positions = new long[n];
        for (int i = 0; i < n; i++) {
            positions[i] = (long) nums[i] + (s.charAt(i) == 'L' ? -d : d);
        }
        Arrays.sort(positions);
        long res = 0;
        long prefix = 0;
        long mod = 1_000_000_007;
        for (int i = 0; i < n; i++) {
            res = (res + positions[i] * i - prefix) % mod;
            prefix = (prefix + positions[i]) % mod;
        }
        return (int) res;
    }
}