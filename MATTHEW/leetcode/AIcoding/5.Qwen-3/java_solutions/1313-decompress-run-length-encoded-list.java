public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> decompressRLEnabled(int[] nums) {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < nums.length; i += 2) {
            int freq = nums[i];
            int val = nums[i + 1];
            for (int j = 0; j < freq; j++) {
                result.add(val);
            }
        }
        return result;
    }
}
}