public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> maxSubArraySum(int[] nums, int target) {
        List<Integer> result = new ArrayList<>();
        int n = nums.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, -1);
        int last = -1;
        for (int i = 0; i < n; i++) {
            int current = prefixSum[i + 1];
            if (map.containsKey(current - target)) {
                int start = map.get(current - target) + 1;
                if (start > last) {
                    result.add(start);
                    result.add(i);
                    last = i;
                }
            }
            map.put(prefixSum[i + 1], i);
        }
        return result;
    }
}
}