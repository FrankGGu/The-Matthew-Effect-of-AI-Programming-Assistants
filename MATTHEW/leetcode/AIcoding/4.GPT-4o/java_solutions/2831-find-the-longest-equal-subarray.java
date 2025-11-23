class Solution {
    public int longestEqualSubarray(int[] nums, int k) {
        int maxLength = 0, left = 0, count = 0;
        int[] freq = new int[101];

        for (int right = 0; right < nums.length; right++) {
            freq[nums[right]]++;
            count = Math.max(count, freq[nums[right]]);

            while (right - left + 1 - count > k) {
                freq[nums[left]]--;
                left++;
            }

            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }
}