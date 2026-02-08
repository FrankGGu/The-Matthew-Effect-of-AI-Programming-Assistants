public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    private Map<Integer, Integer> memo = new HashMap<>();

    public int minDays(int n) {
        return dfs(n);
    }

    private int dfs(int n) {
        if (n <= 1) {
            return n;
        }
        if (memo.containsKey(n)) {
            return memo.get(n);
        }
        int option1 = 1 + dfs(n / 2) + n % 2;
        int option2 = 1 + dfs(n / 3) + n % 3;
        int result = Math.min(option1, option2);
        memo.put(n, result);
        return result;
    }
}
}