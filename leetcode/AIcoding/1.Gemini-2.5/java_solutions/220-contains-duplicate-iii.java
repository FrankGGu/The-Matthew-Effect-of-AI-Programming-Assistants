import java.util.TreeSet;

class Solution {
    public boolean containsNearbyAlmostDuplicate(int[] nums, int k, int t) {
        if (t < 0) {
            return false;
        }

        TreeSet<Long> set = new TreeSet<>();

        for (int i = 0; i < nums.length; i++) {
            long currentNum = nums[i];

            // Check if there is an element x in the set such that abs(x - currentNum) <= t
            // This is equivalent to checking if there is an x in [currentNum - t, currentNum + t]

            // Find the smallest element in the set that is greater than or equal to currentNum - t
            Long ceiling = set.ceiling(currentNum - t);
            if (ceiling != null && ceiling <= currentNum + t) {
                return true;
            }

            // Add current element to the set
            set.add(currentNum);

            // If the window size exceeds k, remove the element that is k positions behind
            // The window contains elements for indices [i-k, i-1]
            // When i becomes k, we need to remove nums[0]
            // When i becomes k+1, we need to remove nums[1]
            // In general, when i reaches k, remove nums[i-k]
            if (i >= k) {
                set.remove((long)nums[i - k]);
            }
        }

        return false;
    }
}