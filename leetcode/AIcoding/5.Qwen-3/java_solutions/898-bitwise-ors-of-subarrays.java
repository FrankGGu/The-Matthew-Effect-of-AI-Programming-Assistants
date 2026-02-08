public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int subarrayBitwiseORS(int[] nums) {
        Set<Integer> result = new HashSet<>();
        Set<Integer> prev = new HashSet<>();

        for (int num : nums) {
            Set<Integer> curr = new HashSet<>();
            curr.add(num);
            for (int p : prev) {
                curr.add(p | num);
            }
            result.addAll(curr);
            prev = curr;
        }

        return result.size();
    }
}
}