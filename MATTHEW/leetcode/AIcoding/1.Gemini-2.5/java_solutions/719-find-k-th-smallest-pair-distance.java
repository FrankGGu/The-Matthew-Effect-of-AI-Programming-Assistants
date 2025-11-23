import java.util.Arrays;

class Solution {
    public int smallestDistancePair(int[] nums, int k) {
        Arrays.sort(nums);

        int n = nums.length;
        int low = 0;
        int high = nums[n - 1] - nums[0];
        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int count = countPairs(nums, mid);

            if (count >= k) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }

    private int countPairs(int[] nums, int maxDiff) {
        int count = 0;
        int n = nums.length;
        int left = 0;
        for (int right = 0; right < n; right++) {
            while (nums[right] - nums[left] > maxDiff) {
                left++;
            }
            count += (right - left);
        }
        return count;
    }
}