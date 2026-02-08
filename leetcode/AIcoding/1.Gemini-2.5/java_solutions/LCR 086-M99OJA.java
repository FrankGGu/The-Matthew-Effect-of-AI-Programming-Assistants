import java.util.ArrayList;
import java.util.List;

class Solution {
    List<List<String>> result;
    String s;
    boolean[][] dp;

    public List<List<String>> partition(String s) {
        this.s = s;
        this.result = new ArrayList<>();
        int n = s.length();
        this.dp = new boolean[n][n];

        for (int i = n - 1; i >= 0; i--) {
            for (int j = i; j < n; j++) {
                if (s.charAt(i) == s.charAt(j) && (j - i <= 2 || dp[i + 1][j - 1])) {
                    dp[i][j] = true;
                }
            }
        }

        backtrack(0, new ArrayList<>());
        return result;
    }

    private void backtrack(int start, List<String> currentPartition) {
        if (start == s.length()) {
            result.add(new ArrayList<>(currentPartition));
            return;
        }

        for (int i = start; i < s.length(); i++) {
            if (dp[start][i]) {
                currentPartition.add(s.substring(start, i + 1));
                backtrack(i + 1, currentPartition);
                currentPartition.remove(currentPartition.size() - 1);
            }
        }
    }
}