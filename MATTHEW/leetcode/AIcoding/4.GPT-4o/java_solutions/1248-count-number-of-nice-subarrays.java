class Solution {
    public int niceSubarrays(int[] nums, int k) {
        return atMostK(nums, k) - atMostK(nums, k - 1);
    }

    private int atMostK(int[] nums, int k) {
        int count = 0, left = 0;
        for (int right = 0; right < nums.length; right++) {
            if (nums[right] % 2 == 1) k--;
            while (k < 0) {
                if (nums[left] % 2 == 1) k++;
                left++;
            }
            count += right - left + 1;
        }
        return count;
    }
}