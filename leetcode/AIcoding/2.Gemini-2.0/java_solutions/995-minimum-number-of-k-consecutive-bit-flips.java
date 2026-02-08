class Solution {
    public int minKBitFlips(int[] nums, int k) {
        int n = nums.length;
        int flips = 0;
        int ans = 0;
        int[] diff = new int[n + 1];

        for (int i = 0; i < n; i++) {
            flips += diff[i];
            if ((nums[i] + flips) % 2 == 0) {
                if (i + k > n) {
                    return -1;
                }
                ans++;
                flips++;
                diff[i + k]--;
            }
        }
        return ans;
    }
}