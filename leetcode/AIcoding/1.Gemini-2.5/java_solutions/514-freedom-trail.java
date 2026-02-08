import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;

class Solution {
    public int findRotateSteps(String ring, String key) {
        int n = ring.length();
        int m = key.length();

        List<Integer>[] char_pos = new List[26];
        for (int i = 0; i < 26; i++) {
            char_pos[i] = new ArrayList<>();
        }
        for (int i = 0; i < n; i++) {
            char_pos[ring.charAt(i) - 'a'].add(i);
        }

        int[] dp_prev = new int[n];

        Arrays.fill(dp_prev, Integer.MAX_VALUE);
        char firstKeyChar = key.charAt(0);
        for (int r_pos : char_pos[firstKeyChar - 'a']) {
            dp_prev[r_pos] = Math.min(r_pos, n - r_pos) + 1;
        }

        for (int k_idx = 1; k_idx < m; k_idx++) {
            int[] dp_curr = new int[n];
            Arrays.fill(dp_curr, Integer.MAX_VALUE);
            char currentKeyChar = key.charAt(k_idx);
            char prevKeyChar = key.charAt(k_idx - 1);

            for (int curr_r_pos : char_pos[currentKeyChar - 'a']) {
                for (int prev_r_pos : char_pos[prevKeyChar - 'a']) {
                    if (dp_prev[prev_r_pos] != Integer.MAX_VALUE) {
                        int diff = Math.abs(curr_r_pos - prev_r_pos);
                        int rotation_steps = Math.min(diff, n - diff);

                        dp_curr[curr_r_pos] = Math.min(dp_curr[curr_r_pos], 
                                                        dp_prev[prev_r_pos] + rotation_steps + 1);
                    }
                }
            }
            dp_prev = dp_curr;
        }

        int minSteps = Integer.MAX_VALUE;
        for (int steps : dp_prev) {
            minSteps = Math.min(minSteps, steps);
        }

        return minSteps;
    }
}