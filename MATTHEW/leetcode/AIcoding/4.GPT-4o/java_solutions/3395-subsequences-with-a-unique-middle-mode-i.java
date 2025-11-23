import java.util.*;

public class Solution {
    public int uniqueMiddleMode(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int mode = 0;
        int maxCount = 0;
        boolean unique = true;

        for (Map.Entry<Integer, Integer> entry : freq.entrySet()) {
            int count = entry.getValue();
            if (count > maxCount) {
                maxCount = count;
                mode = entry.getKey();
                unique = true;
            } else if (count == maxCount) {
                unique = false;
            }
        }

        return unique ? mode : -1;
    }
}