import java.util.Arrays;

class Solution {
    public int numSubseq(int[] nums, int target) {
        Arrays.sort(nums);
        int n = nums.length;
        int mod = 1_000_000_007;

        long[] powers = new long[n];
        powers[0] = 1;
        for (int i = 1; i < n; i++) {
            powers[i] = (powers[i - 1] * 2) % mod;
        }

        int ans = 0;
        int left = 0;
        int right = n - 1;

        while (left <= right) {
            if (nums[left] + nums[right] <= target) {
                // If nums[left] is the minimum element, and nums[right] is the maximum element,
                // then any subsequence formed by nums[left], nums[right], and any subset
                // of elements between them (nums[left+1]...nums[right-1]) will satisfy the condition.
                // More generally, if nums[left] is chosen as the minimum, and nums[left] + nums[right] <= target,
                // then any element nums[k] where left <= k <= right can be the maximum element
                // of a valid subsequence that includes nums[left].
                // The number of ways to pick the remaining elements from nums[left+1]...nums[right]
                // is 2^(right - left).
                ans = (int) ((ans + powers[right - left]) % mod);
                left++;
            } else {
                // If nums[left] + nums[right] > target, then nums[right] is too large
                // to be the maximum element for nums[left] (or any element smaller than nums[left]).
                // We must try a smaller maximum element.
                right--;
            }
        }

        return ans;
    }
}