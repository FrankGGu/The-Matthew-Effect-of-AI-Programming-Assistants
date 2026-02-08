public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int arithmeticTriplets(int[] nums, int target) {
        Set<Integer> set = new HashSet<>();
        for (int num : nums) {
            set.add(num);
        }
        int count = 0;
        for (int num : nums) {
            if (set.contains(num + target) && set.contains(num + 2 * target)) {
                count++;
            }
        }
        return count;
    }
}
}