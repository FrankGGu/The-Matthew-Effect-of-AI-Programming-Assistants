public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findSubstringInWrapup(String s) {
        int[] dp = new int[s.length()];
        Arrays.fill(dp, 1);
        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) - s.charAt(i - 1) == 1) {
                dp[i] = dp[i - 1] + 1;
            }
        }
        Map<Character, Integer> map = new HashMap<>();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (map.getOrDefault(c, 0) < dp[i]) {
                map.put(c, dp[i]);
            }
        }
        List<Integer> result = new ArrayList<>();
        for (int val : map.values()) {
            result.add(val);
        }
        return result;
    }
}
}