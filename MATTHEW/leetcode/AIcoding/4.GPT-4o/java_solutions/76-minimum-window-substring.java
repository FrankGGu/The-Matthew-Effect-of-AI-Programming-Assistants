import java.util.HashMap;

public class Solution {
    public String minWindow(String s, String t) {
        if (t.length() == 0 || s.length() == 0) return "";

        HashMap<Character, Integer> tCount = new HashMap<>();
        for (char c : t.toCharArray()) {
            tCount.put(c, tCount.getOrDefault(c, 0) + 1);
        }

        int required = tCount.size();
        int left = 0, right = 0, formed = 0;
        HashMap<Character, Integer> windowCounts = new HashMap<>();

        int[] ans = {Integer.MAX_VALUE, 0, 0};

        while (right < s.length()) {
            char c = s.charAt(right);
            windowCounts.put(c, windowCounts.getOrDefault(c, 0) + 1);

            if (tCount.containsKey(c) && windowCounts.get(c).intValue() == tCount.get(c).intValue()) {
                formed++;
            }

            while (left <= right && formed == required) {
                char lChar = s.charAt(left);

                if (right - left + 1 < ans[0]) {
                    ans[0] = right - left + 1;
                    ans[1] = left;
                    ans[2] = right;
                }

                windowCounts.put(lChar, windowCounts.get(lChar) - 1);
                if (tCount.containsKey(lChar) && windowCounts.get(lChar).intValue() < tCount.get(lChar).intValue()) {
                    formed--;
                }
                left++;
            }
            right++;
        }

        return ans[0] == Integer.MAX_VALUE ? "" : s.substring(ans[1], ans[2] + 1);
    }
}