import java.util.HashSet;
import java.util.Set;

class Solution {
    public int maxNonOverlapping(int[] nums, int target) {
        int count = 0;
        int sum = 0;
        Set<Integer> seen = new HashSet<>();
        seen.add(0);

        for (int num : nums) {
            sum += num;
            if (seen.contains(sum - target)) {
                count++;
                sum = 0;
                seen = new HashSet<>();
                seen.add(0);
            } else {
                seen.add(sum);
            }
        }

        return count;
    }
}