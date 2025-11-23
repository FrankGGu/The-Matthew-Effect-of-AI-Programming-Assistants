public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findBeautifulIndices(int[] nums, int k) {
        List<Integer> result = new ArrayList<>();
        TreeSet<Integer> set = new TreeSet<>();

        for (int i = 0; i < nums.length; i++) {
            if (set.floor(i) != null && i - set.floor(i) <= k) {
                result.add(i);
            } else if (set.ceiling(i) != null && set.ceiling(i) - i <= k) {
                result.add(i);
            } else {
                set.add(i);
            }
        }

        return result;
    }
}
}