public class Solution {

import java.util.*;

public class Solution {
    public int maximumScore(List<Integer> nums, int k) {
        int n = nums.size();
        int[] left = new int[n];
        int[] right = new int[n];
        Arrays.fill(left, 1);
        Arrays.fill(right, 1);

        for (int i = 1; i < n; i++) {
            if (nums.get(i) < nums.get(i - 1)) {
                left[i] = 1;
            } else {
                left[i] = left[i - 1] + 1;
            }
        }

        for (int i = n - 2; i >= 0; i--) {
            if (nums.get(i) > nums.get(i + 1)) {
                right[i] = 1;
            } else {
                right[i] = right[i + 1] + 1;
            }
        }

        int maxScore = 0;
        for (int i = 0; i < n; i++) {
            int count = left[i] + right[i] - 1;
            int score = nums.get(i) * count;
            maxScore = Math.max(maxScore, score);
        }

        return maxScore;
    }
}
}