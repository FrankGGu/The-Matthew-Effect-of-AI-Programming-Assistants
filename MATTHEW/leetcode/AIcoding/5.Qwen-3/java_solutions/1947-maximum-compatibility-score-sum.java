public class Solution {

import java.util.*;

public class Solution {
    public int maxCompatibilitySum(int[][] students, int[][] mentors) {
        int n = students.length;
        int m = students[0].length;
        int[] scores = new int[n];
        for (int i = 0; i < n; i++) {
            int score = 0;
            for (int j = 0; j < m; j++) {
                if (students[i][j] == mentors[i][j]) {
                    score++;
                }
            }
            scores[i] = score;
        }
        return backtrack(0, new boolean[n], scores, new int[n], 0);
    }

    private int backtrack(int index, boolean[] used, int[] scores, int[] current, int sum) {
        if (index == scores.length) {
            return sum;
        }
        int max = 0;
        for (int i = 0; i < scores.length; i++) {
            if (!used[i]) {
                used[i] = true;
                current[index] = scores[i];
                max = Math.max(max, backtrack(index + 1, used, scores, current, sum + scores[i]));
                used[i] = false;
            }
        }
        return max;
    }
}
}