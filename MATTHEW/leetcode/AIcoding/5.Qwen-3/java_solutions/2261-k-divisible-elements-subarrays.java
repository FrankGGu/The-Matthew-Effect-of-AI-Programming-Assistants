public class Solution {

import java.util.*;

public class Solution {
    public int kDivisibleElementsSubarrays(int[] nums, int k) {
        int n = nums.length;
        int count = 0;
        Set<Integer> seen = new HashSet<>();

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                if ((j - i + 1) % k == 0) {
                    int hash = 0;
                    for (int m = i; m <= j; m++) {
                        hash = hash * 10 + nums[m];
                    }
                    if (!seen.contains(hash)) {
                        seen.add(hash);
                        count++;
                    }
                }
            }
        }

        return count;
    }
}
}