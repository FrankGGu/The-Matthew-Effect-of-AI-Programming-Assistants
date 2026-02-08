public class Solution {

import java.util.*;

public class Solution {
    public int minGroups(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        List<Map.Entry<Integer, Integer>> entries = new ArrayList<>(freq.entrySet());
        entries.sort((a, b) -> b.getValue() - a.getValue());

        int maxFreq = entries.get(0).getValue();
        int minGroups = 0;

        for (int i = 0; i < entries.size(); i++) {
            int count = entries.get(i).getValue();
            int groupSize = (int) Math.ceil((double) count / maxFreq);
            minGroups += groupSize;
        }

        return minGroups;
    }
}
}