public class Solution {

import java.util.*;

public class Solution {
    public int minImpossibleOR(int[] nums) {
        Set<Integer> set = new HashSet<>();
        for (int num : nums) {
            set.add(num);
        }
        int result = 1;
        while (set.contains(result)) {
            result <<= 1;
        }
        return result;
    }
}
}