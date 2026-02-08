import java.util.HashSet;
import java.util.Set;

class Solution {
    public int findMaxK(int[] nums) {
        Set<Integer> set = new HashSet<>();
        int maxK = -1;
        for (int num : nums) {
            set.add(num);
        }
        for (int num : nums) {
            if (num > 0 && set.contains(-num)) {
                maxK = Math.max(maxK, num);
            }
        }
        return maxK;
    }
}