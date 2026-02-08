public class Solution {

import java.util.*;

public class Solution {
    public int[] distinctNumbersAfterOps(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        Set<Integer> seen = new HashSet<>();
        for (int i = 0; i < n; i++) {
            int num = nums[i];
            if (seen.contains(num)) {
                continue;
            }
            seen.add(num);
            int count = 1;
            for (int j = i + 1; j < n; j++) {
                if (nums[j] == num) {
                    count++;
                }
            }
            result[i] = count;
        }
        return result;
    }
}
}