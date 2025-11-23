class Solution {
    public long countSubarrays(int[] nums, int k) {
        int n = nums.length;
        long res = 0;
        int left = 0;
        int max = 0;
        int count = 0;

        for (int num : nums) {
            max = Math.max(max, num);
        }

        for (int right = 0; right < n; right++) {
            if (nums[right] == max) {
                count++;
            }
            while (count >= k) {
                if (nums[left] == max) {
                    count--;
                }
                left++;
            }
            res += left;
        }
        return res;
    }
}