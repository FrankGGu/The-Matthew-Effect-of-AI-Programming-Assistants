class Solution {
    public long countSubarrays(int[] nums, int k) {
        long ans = 0;
        int n = nums.length;
        int left = 0;
        int start = -1;
        int end = -1;

        for (int right = 0; right < n; right++) {
            if (nums[right] == k) {
                start = end;
                end = right;
            }

            while (start >= 0 && nums[left] < k) {
                left++;
            }

            if (start >= 0) {
                ans += (long) (start - left + 1);
            }
        }

        return ans;
    }
}