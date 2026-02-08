import java.util.HashSet;
import java.util.Set;

class Solution {
    public int findAlmostMissing(int[] nums, int m) {
        Set<Integer> seen = new HashSet<>();
        int n = nums.length;
        for (int num : nums) {
            if (num <= n) {
                seen.add(num);
            }
        }

        for (int i = 1; i <= n + 1; i++) {
            if (!seen.contains(i)) {
                return i;
            }
        }

        return -1;
    }
}