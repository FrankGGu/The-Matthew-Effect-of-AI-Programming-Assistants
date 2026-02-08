public class Solution {

import java.util.*;

public class Solution {
    public int beautifulSubarrays(int[] nums) {
        Map<Integer, Integer> prefixCount = new HashMap<>();
        prefixCount.put(0, 1);
        int count = 0;
        int prefixXor = 0;

        for (int num : nums) {
            prefixXor ^= num;
            count += prefixCount.getOrDefault(prefixXor, 0);
            prefixCount.put(prefixXor, prefixCount.getOrDefault(prefixXor, 0) + 1);
        }

        return count;
    }
}
}