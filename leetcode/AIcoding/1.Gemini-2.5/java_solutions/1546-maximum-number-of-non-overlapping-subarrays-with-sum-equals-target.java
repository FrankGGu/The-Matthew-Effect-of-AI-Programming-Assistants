import java.util.HashSet;
import java.util.Set;

class Solution {
    public int maxNonOverlapping(int[] nums, int target) {
        int count = 0;
        int currentSum = 0;
        Set<Integer> seenSums = new HashSet<>();
        seenSums.add(0);

        for (int num : nums) {
            currentSum += num;
            if (seenSums.contains(currentSum - target)) {
                count++;
                currentSum = 0;
                seenSums.clear();
                seenSums.add(0);
            } else {
                seenSums.add(currentSum);
            }
        }
        return count;
    }
}