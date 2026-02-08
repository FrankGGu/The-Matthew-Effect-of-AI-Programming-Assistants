public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    private static final double EPSILON = 1e-5;
    private static final Map<String, Double> memo = new HashMap<>();

    public double soupServings(int n) {
        return dfs(n, n);
    }

    private double dfs(int a, int b) {
        if (a <= 0 && b <= 0) return 0.5;
        if (a <= 0) return 1.0;
        if (b <= 0) return 0.0;
        String key = a + "," + b;
        if (memo.containsKey(key)) return memo.get(key);
        double result = 0.25 * dfs(a - 100, b - 0);
        result += 0.25 * dfs(a - 75, b - 25);
        result += 0.25 * dfs(a - 50, b - 50);
        result += 0.25 * dfs(a - 25, b - 75);
        memo.put(key, result);
        return result;
    }
}
}