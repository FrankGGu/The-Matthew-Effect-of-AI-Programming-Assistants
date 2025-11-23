public class Solution {

import java.util.*;

public class Solution {
    public int findLargestAlmostMissingInteger(int[] nums) {
        Map<Integer, Integer> frequency = new HashMap<>();
        for (int num : nums) {
            frequency.put(num, frequency.getOrDefault(num, 0) + 1);
        }

        List<Map.Entry<Integer, Integer>> entries = new ArrayList<>(frequency.entrySet());
        entries.sort((a, b) -> b.getValue() - a.getValue());

        int max = -1;
        for (int i = 0; i < entries.size(); i++) {
            if (i == 0) {
                continue;
            }
            int prevFreq = entries.get(i - 1).getValue();
            int currFreq = entries.get(i).getValue();
            if (prevFreq > currFreq) {
                return entries.get(i).getKey();
            }
        }

        return max;
    }
}
}