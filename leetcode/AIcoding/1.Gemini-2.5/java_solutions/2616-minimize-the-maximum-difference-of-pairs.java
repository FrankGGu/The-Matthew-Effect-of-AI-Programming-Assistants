import java.util.Arrays;

class Solution {
    public int minimizeMax(int[] nums, int p) {
        Arrays.sort(nums);
        int n = nums.length;

        int low = 0;
        int high = nums[n - 1] - nums[0];
        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;

            if (canFormPairs(nums, p, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }

    private boolean canFormPairs(int[] nums, int p, int maxDiff) {
        int count = 0;
        for (int i = 0; i < nums.length - 1; ) {
            if (nums[i + 1] - nums[i] <= maxDiff) {
                count++;
                i += 2; // Move to the next available element after forming a pair
            } else {
                i += 1; // Cannot form a pair, move to the next element
            }
            if (count >= p) {
                return true;
            }
        }
        return count >= p;
    }
}