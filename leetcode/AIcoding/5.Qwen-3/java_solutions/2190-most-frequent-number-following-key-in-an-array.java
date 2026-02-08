public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int mostFrequent(int[] nums, int key) {
        Map<Integer, Integer> frequency = new HashMap<>();
        int maxFreq = 0;
        int result = -1;

        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] == key) {
                int nextNum = nums[i + 1];
                frequency.put(nextNum, frequency.getOrDefault(nextNum, 0) + 1);
                if (frequency.get(nextNum) > maxFreq) {
                    maxFreq = frequency.get(nextNum);
                    result = nextNum;
                }
            }
        }

        return result;
    }
}
}