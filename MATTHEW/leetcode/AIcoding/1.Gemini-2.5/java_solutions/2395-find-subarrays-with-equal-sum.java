import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean findSubarrays(int[] nums) {
        Set<Integer> sums = new HashSet<>();
        for (int i = 0; i < nums.length - 1; i++) {
            int currentSum = nums[i] + nums[i + 1];
            if (sums.contains(currentSum)) {
                return true;
            }
            sums.add(currentSum);
        }
        return false;
    }
}