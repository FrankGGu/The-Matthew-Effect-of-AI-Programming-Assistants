public class Solution {

import java.util.*;

public class Solution {
    public int maximumPalindromes(int[] nums) {
        Map<Character, Integer> freq = new HashMap<>();
        for (int num : nums) {
            char c = (char) ('a' + num);
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }

        List<Integer> counts = new ArrayList<>(freq.values());
        Collections.sort(counts, Collections.reverseOrder());

        int pairs = 0;
        int single = 0;

        for (int count : counts) {
            pairs += count / 2;
            if (count % 2 == 1) {
                single = 1;
            }
        }

        int result = 0;
        while (pairs > 0) {
            result++;
            pairs -= 1;
            if (single == 1 && pairs > 0) {
                result++;
                pairs -= 1;
                single = 0;
            }
        }

        return result;
    }
}
}