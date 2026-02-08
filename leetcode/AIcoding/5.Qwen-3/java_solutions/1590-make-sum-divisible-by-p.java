public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int minSubarray(int[] nums, int p) {
        int n = nums.length;
        int total = 0;
        for (int num : nums) {
            total = (total + num) % p;
        }
        if (total == 0) {
            return 0;
        }
        int target = (total % p + p) % p;
        Map<Integer, Integer> prefixMap = new HashMap<>();
        prefixMap.put(0, -1);
        int currentSum = 0;
        int minLen = n;
        for (int i = 0; i < n; i++) {
            currentSum = (currentSum + nums[i]) % p;
            int remainder = (currentSum - target + p) % p;
            if (prefixMap.containsKey(remainder)) {
                minLen = Math.min(minLen, i - prefixMap.get(remainder));
            }
            prefixMap.put(currentSum, i);
        }
        return minLen == n ? -1 : minLen;
    }
}
}