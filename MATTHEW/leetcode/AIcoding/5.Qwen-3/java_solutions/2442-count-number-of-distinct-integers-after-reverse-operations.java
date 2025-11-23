public class Solution {

import java.util.*;

public class Solution {
    public int countDistinctIntegersInReverse(int[] nums) {
        Set<Integer> set = new HashSet<>();
        for (int num : nums) {
            set.add(num);
            int reversed = 0;
            int n = num;
            while (n > 0) {
                reversed = reversed * 10 + n % 10;
                n /= 10;
            }
            set.add(reversed);
        }
        return set.size();
    }
}
}