import java.util.TreeSet;

class Solution {
    public boolean containsNearbyAlmostDuplicate(int[] nums, int k, int t) {
        if (k < 0 || t < 0) {
            return false;
        }

        TreeSet<Long> window = new TreeSet<>();

        for (int i = 0; i < nums.length; i++) {
            // Check if there is any element in the current window [nums[i]-t, nums[i]+t]
            // Find the smallest element in the window that is greater than or equal to nums[i] - t
            Long floor = window.floor((long) nums[i] + t);
            if (floor != null && floor >= (long) nums[i] - t) {
                return true;
            }

            // Add the current number to the window
            window.add((long) nums[i]);

            // If the window size exceeds k, remove the element nums[i-k]
            if (i >= k) {
                window.remove((long) nums[i - k]);
            }
        }

        return false;
    }
}