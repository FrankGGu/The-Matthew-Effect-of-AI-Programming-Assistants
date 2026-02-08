public class Solution {

import java.util.*;

public class Solution {
    public int countCompleteSubarrays(List<Integer> nums) {
        Set<Integer> unique = new HashSet<>(nums);
        int uniqueCount = unique.size();
        int n = nums.size();
        int result = 0;
        for (int i = 0; i < n; i++) {
            Map<Integer, Integer> freq = new HashMap<>();
            int count = 0;
            for (int j = i; j < n; j++) {
                int num = nums.get(j);
                freq.put(num, freq.getOrDefault(num, 0) + 1);
                if (freq.get(num) == 1) {
                    count++;
                }
                if (count == uniqueCount) {
                    result++;
                }
            }
        }
        return result;
    }
}
}