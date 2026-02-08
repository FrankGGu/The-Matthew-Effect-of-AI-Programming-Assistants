public class Solution {

import java.util.*;

public class Solution {
    public int[] findErrorNums(int[] nums) {
        int n = nums.length;
        int[] result = new int[2];
        Set<Integer> seen = new HashSet<>();

        for (int num : nums) {
            if (seen.contains(num)) {
                result[0] = num;
            } else {
                seen.add(num);
            }
        }

        for (int i = 1; i <= n; i++) {
            if (!seen.contains(i)) {
                result[1] = i;
                break;
            }
        }

        return result;
    }
}
}