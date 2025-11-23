public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> numPairsDivisibleBy60(int[] nums) {
        int[] count = new int[60];
        List<Integer> result = new ArrayList<>();

        for (int num : nums) {
            int mod = num % 60;
            if (mod == 0) {
                result.add(count[0]);
            } else {
                result.add(count[60 - mod]);
            }
            count[mod]++;
        }

        return result;
    }
}
}