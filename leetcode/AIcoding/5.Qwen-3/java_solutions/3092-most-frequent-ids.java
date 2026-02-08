public class Solution {

import java.util.*;

public class Solution {
    public int[] mostFrequent(int[] ids) {
        Map<Integer, Integer> freq = new HashMap<>();
        int maxFreq = 0;
        List<Integer> result = new ArrayList<>();

        for (int id : ids) {
            freq.put(id, freq.getOrDefault(id, 0) + 1);
            maxFreq = Math.max(maxFreq, freq.get(id));
            result.add(maxFreq);
        }

        int[] output = new int[result.size()];
        for (int i = 0; i < output.length; i++) {
            output[i] = result.get(i);
        }
        return output;
    }
}
}