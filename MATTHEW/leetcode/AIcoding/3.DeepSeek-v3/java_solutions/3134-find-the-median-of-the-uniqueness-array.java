class Solution {
    public int medianOfUniquenessArray(int[] nums) {
        int n = nums.length;
        int totalSubarrays = n * (n + 1) / 2;
        int k = (totalSubarrays + 1) / 2;

        int left = 1, right = n;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (countSubarraysWithAtMostKDistinct(nums, mid) >= k) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private long countSubarraysWithAtMostKDistinct(int[] nums, int k) {
        int n = nums.length;
        int[] freq = new int[100001];
        int distinct = 0;
        long count = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            if (freq[nums[right]] == 0) {
                distinct++;
            }
            freq[nums[right]]++;

            while (distinct > k) {
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    distinct--;
                }
                left++;
            }
            count += right - left + 1;
        }
        return count;
    }
}