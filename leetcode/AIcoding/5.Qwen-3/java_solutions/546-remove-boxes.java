public class Solution {

import java.util.*;

public class Solution {
    public int removeBoxes(int[] boxes) {
        int n = boxes.length;
        int[][][] dp = new int[n][n][n];
        return helper(boxes, 0, n - 1, 0, dp);
    }

    private int helper(int[] boxes, int left, int right, int k, int[][][] dp) {
        if (left > right) return 0;
        if (dp[left][right][k] != 0) return dp[left][right][k];
        int originalK = k;
        while (left < right && boxes[right] == boxes[right - 1]) {
            right--;
            k++;
        }
        int res = helper(boxes, left, right - 1, k, dp) + (k + 1) * (k + 1);
        for (int i = left; i < right; i++) {
            if (boxes[i] == boxes[right]) {
                res = Math.max(res, helper(boxes, left, i, k + 1, dp) + helper(boxes, i + 1, right - 1, 0, dp));
            }
        }
        dp[left][right][originalK] = res;
        return res;
    }
}
}