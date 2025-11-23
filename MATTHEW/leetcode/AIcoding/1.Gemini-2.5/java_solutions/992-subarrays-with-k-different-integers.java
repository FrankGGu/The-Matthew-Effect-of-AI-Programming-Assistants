class Solution {
    public int subarraysWithKDistinct(int[] nums, int k) {
        return subarraysWithAtMostKDistinct(nums, k) - subarraysWithAtMostKDistinct(nums, k - 1);
    }

    private int subarraysWithAtMostKDistinct(int[] nums, int k) {
        int left = 0;
        int totalCount = 0;
        int distinctCount = 0;
        int[] freq = new int[nums.length + 1];

        for (int right = 0; right < nums.length; right++) {
            if (freq[nums[right]] == 0) {
                distinctCount++;
            }
            freq[nums[right]]++;

            while (distinctCount > k) {
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    distinctCount--;
                }
                left++;
            }
            totalCount += (right - left + 1);
        }
        return totalCount;
    }
}