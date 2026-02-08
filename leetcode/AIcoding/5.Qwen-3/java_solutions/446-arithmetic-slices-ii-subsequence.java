public class Solution {

import java.util.*;

public class Solution {
    public int numberOfArithmeticSlices(int[] nums) {
        int n = nums.length;
        List<Map<Long, Integer>> dp = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            dp.add(new HashMap<>());
        }
        int result = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                long diff = (long) nums[i] - nums[j];
                Map<Long, Integer> map = dp.get(i);
                Map<Long, Integer> prevMap = dp.get(j);
                int count = prevMap.getOrDefault(diff, 0);
                map.put(diff, map.getOrDefault(diff, 0) + count + 1);
                result += count;
            }
        }
        return result;
    }
}
}