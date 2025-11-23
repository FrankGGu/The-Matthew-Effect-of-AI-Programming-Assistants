import java.util.HashSet;
import java.util.Set;

class Solution {
    public int findLargestAlmostMissingInteger(int[] nums) {
        Set<Integer> set = new HashSet<>();
        for (int num : nums) {
            set.add(num);
        }

        int maxMissing = -1;
        for (int num : nums) {
            if (!set.contains(num + 1)) {
                if (num > maxMissing) {
                    maxMissing = num;
                }
            }
        }

        return maxMissing;
    }
}