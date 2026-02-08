public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findPrefixScores(int[] nums) {
        int n = nums.length;
        List<Integer> result = new ArrayList<>();
        int score = 0;
        int prefixSum = 0;

        for (int i = 0; i < n; i++) {
            prefixSum += nums[i];
            score += prefixSum;
            result.add(score);
        }

        return result;
    }
}
}