public class Solution {

import java.util.*;

public class Solution {
    public int[] numberOfPairs(int[] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        int pairs = 0;
        int remaining = 0;

        for (int count : countMap.values()) {
            pairs += count / 2;
            remaining += count % 2;
        }

        return new int[]{pairs, remaining};
    }
}
}