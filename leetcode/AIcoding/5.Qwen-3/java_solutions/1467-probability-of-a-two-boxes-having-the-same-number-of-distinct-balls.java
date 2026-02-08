public class Solution {

import java.util.*;

public class Solution {
    public double getProbability(List<Integer> balls) {
        int total = 0;
        for (int ball : balls) {
            total += ball;
        }
        int[] count = new int[10];
        for (int i = 0; i < balls.size(); i++) {
            count[i] = balls.get(i);
        }
        return dfs(count, 0, 0, 0, 0, total / 2, total / 2, 0, 0);
    }

    private double dfs(int[] count, int index, int leftBalls, int rightBalls, int leftDistinct, int leftTarget, int rightTarget, int leftUnique, int rightUnique) {
        if (index == count.length) {
            return leftBalls == leftTarget && rightBalls == rightTarget ? 1.0 : 0.0;
        }
        double total = 0.0;
        for (int i = 0; i <= count[index]; i++) {
            int remaining = count[index] - i;
            int newLeftBalls = leftBalls + i;
            int newRightBalls = rightBalls + remaining;
            int newLeftDistinct = leftDistinct + (i > 0 ? 1 : 0);
            int newRightDistinct = rightUnique + (remaining > 0 ? 1 : 0);
            if (newLeftBalls > leftTarget || newRightBalls > rightTarget) {
                continue;
            }
            double ways = comb(count[index], i);
            total += ways * dfs(count, index + 1, newLeftBalls, newRightBalls, newLeftDistinct, leftTarget, rightTarget, newLeftDistinct, newRightDistinct);
        }
        return total;
    }

    private double comb(int n, int k) {
        if (k < 0 || k > n) return 0.0;
        if (k == 0 || k == n) return 1.0;
        k = Math.min(k, n - k);
        double result = 1.0;
        for (int i = 1; i <= k; i++) {
            result *= (n - k + i);
            result /= i;
        }
        return result;
    }
}
}