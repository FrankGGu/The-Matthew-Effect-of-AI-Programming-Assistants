public class Solution {

import java.util.*;

public class Solution {
    public int minimumOperationsToConvertAllElementsToZero(int[] nums) {
        int n = nums.length;
        int[] prefix = new int[n];
        prefix[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefix[i] = prefix[i - 1] + nums[i];
        }
        Set<Integer> set = new HashSet<>();
        for (int i = 0; i < n; i++) {
            set.add(prefix[i]);
        }
        int res = 0;
        int current = 0;
        for (int i = 0; i < n; i++) {
            if (current != prefix[i]) {
                res++;
                current = prefix[i];
            }
        }
        return res;
    }
}
}