public class Solution {

import java.util.*;

public class Solution {
    public List<String> partition(String s) {
        List<String> result = new ArrayList<>();
        boolean[][] dp = new boolean[s.length()][s.length()];
        for (int i = 0; i < s.length(); i++) {
            for (int j = 0; j <= i; j++) {
                if (s.charAt(i) == s.charAt(j) && (i - j <= 2 || dp[j + 1][i - 1])) {
                    dp[j][i] = true;
                }
            }
        }
        backtrack(s, 0, dp, new ArrayList<>(), result);
        return result;
    }

    private void backtrack(String s, int start, boolean[][] dp, List<String> path, List<String> result) {
        if (start == s.length()) {
            result.add(new String(String.join("", path)));
            return;
        }
        for (int end = start; end < s.length(); end++) {
            if (dp[start][end]) {
                path.add(s.substring(start, end + 1));
                backtrack(s, end + 1, dp, path, result);
                path.remove(path.size() - 1);
            }
        }
    }
}
}