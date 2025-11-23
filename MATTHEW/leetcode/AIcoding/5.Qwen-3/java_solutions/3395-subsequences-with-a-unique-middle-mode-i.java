public class Solution {

import java.util.*;

public class Solution {
    public int countSubseqWithUniqueMiddle(int[] nums) {
        int n = nums.length;
        int result = 0;
        for (int i = 0; i < n; i++) {
            Map<Integer, Integer> freq = new HashMap<>();
            int maxFreq = 0;
            int mode = -1;
            for (int j = i; j < n; j++) {
                freq.put(nums[j], freq.getOrDefault(nums[j], 0) + 1);
                if (freq.get(nums[j]) > maxFreq) {
                    maxFreq = freq.get(nums[j]);
                    mode = nums[j];
                } else if (freq.get(nums[j]) == maxFreq && nums[j] < mode) {
                    mode = nums[j];
                }
                if (maxFreq == 1 || (j - i + 1) % 2 == 1 && freq.get(mode) == maxFreq) {
                    result++;
                }
            }
        }
        return result;
    }
}
}