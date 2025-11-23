import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<List<Integer>> validPatterns;
    private int M;

    private void generatePatterns(int row, List<Integer> currentPattern) {
        if (row == M) {
            validPatterns.add(new ArrayList<>(currentPattern));
            return;
        }
        for (int color = 0; color < 3; color++) {
            if (row > 0 && currentPattern.get(row - 1) == color) {
                continue;
            }
            currentPattern.add(color);
            generatePatterns(row + 1, currentPattern);
            currentPattern.remove(currentPattern.size() - 1);
        }
    }

    private boolean isHorizontalValid(List<Integer> p1, List<Integer> p2) {
        for (int i = 0; i < M; i++) {
            if (p1.get(i) == p2.get(i)) {
                return false;
            }
        }
        return true;
    }

    public int paintGrid(int m, int n) {
        M = m;
        validPatterns = new ArrayList<>();
        generatePatterns(0, new ArrayList<>());

        int numPatterns = validPatterns.size();
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < numPatterns; i++) {
            adj.add(new ArrayList<>());
        }

        for (int prev_pattern_idx = 0; prev_pattern_idx < numPatterns; prev_pattern_idx++) {
            for (int current_pattern_idx = 0; current_pattern_idx < numPatterns; current_pattern_idx++) {
                if (isHorizontalValid(validPatterns.get(prev_pattern_idx), validPatterns.get(current_pattern_idx))) {
                    adj.get(prev_pattern_idx).add(current_pattern_idx);
                }
            }
        }

        long[] dp = new long[numPatterns];
        long MOD = 1_000_000_007;

        for (int i = 0; i < numPatterns; i++) {
            dp[i] = 1;
        }

        for (int col = 1; col < n; col++) {
            long[] next_dp = new long[numPatterns];
            for (int prev_pattern_idx = 0; prev_pattern_idx < numPatterns; prev_pattern_idx++) {
                for (int current_pattern_idx : adj.get(prev_pattern_idx)) {
                    next_dp[current_pattern_idx] = (next_dp[current_pattern_idx] + dp[prev_pattern_idx]) % MOD;
                }
            }
            dp = next_dp;
        }

        long totalWays = 0;
        for (int i = 0; i < numPatterns; i++) {
            totalWays = (totalWays + dp[i]) % MOD;
        }

        return (int) totalWays;
    }
}