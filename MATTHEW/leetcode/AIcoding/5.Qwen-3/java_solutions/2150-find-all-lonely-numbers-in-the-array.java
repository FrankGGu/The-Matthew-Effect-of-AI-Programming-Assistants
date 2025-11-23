public class Solution {

import java.util.*;
import java.util.stream.*;

public class Solution {
    public List<Integer> findLonely(final int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }
        return nums.stream()
                   .filter(num -> count.get(num) == 1 && !count.containsKey(num - 1) && !count.containsKey(num + 1))
                   .collect(Collectors.toList());
    }
}
}