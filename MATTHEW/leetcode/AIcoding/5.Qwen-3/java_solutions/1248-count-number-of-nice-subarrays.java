public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int numberOfNiceSubarrays(int[] nums, int k) {
        Map<Integer, Integer> prefixCount = new HashMap<>();
        prefixCount.put(0, 1);
        int count = 0;
        int prefixSum = 0;

        for (int num : nums) {
            prefixSum += num % 2;
            if (prefixCount.containsKey(prefixSum - k)) {
                count += prefixCount.get(prefixSum - k);
            }
            prefixCount.put(prefixSum, prefixCount.getOrDefault(prefixSum, 0) + 1);
        }

        return count;
    }
}
}