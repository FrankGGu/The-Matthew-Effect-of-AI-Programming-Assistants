class Solution {
    public int numberOfSubarrays(int[] nums, int k) {
        int n = nums.length;
        int[] oddIndices = new int[n + 2];
        oddIndices[0] = -1;
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] % 2 != 0) {
                oddIndices[++count] = i;
            }
        }
        oddIndices[count + 1] = n;

        int ans = 0;
        for (int i = 1; i + k <= count + 1; i++) {
            ans += (oddIndices[i] - oddIndices[i - 1]) * (oddIndices[i + k] - oddIndices[i + k - 1]);
        }

        return ans;
    }
}