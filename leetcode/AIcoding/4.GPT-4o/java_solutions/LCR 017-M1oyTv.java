import java.util.HashMap;

public class Solution {
    public String minWindow(String s, String t) {
        if (t.length() > s.length()) return "";

        HashMap<Character, Integer> mapT = new HashMap<>();
        for (char c : t.toCharArray()) {
            mapT.put(c, mapT.getOrDefault(c, 0) + 1);
        }

        int required = mapT.size();
        int l = 0, r = 0;
        int formed = 0;
        HashMap<Character, Integer> windowCounts = new HashMap<>();

        int[] ans = {-1, 0, 0}; // window length, left, right

        while (r < s.length()) {
            char c = s.charAt(r);
            windowCounts.put(c, windowCounts.getOrDefault(c, 0) + 1);

            if (mapT.containsKey(c) && windowCounts.get(c).intValue() == mapT.get(c).intValue()) {
                formed++;
            }

            while (l <= r && formed == required) {
                c = s.charAt(l);

                if (ans[0] == -1 || r - l + 1 < ans[0]) {
                    ans[0] = r - l + 1;
                    ans[1] = l;
                    ans[2] = r;
                }

                windowCounts.put(c, windowCounts.get(c) - 1);
                if (mapT.containsKey(c) && windowCounts.get(c).intValue() < mapT.get(c).intValue()) {
                    formed--;
                }
                l++;
            }
            r++;
        }

        return ans[0] == -1 ? "" : s.substring(ans[1], ans[2] + 1);
    }
}