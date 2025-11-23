public class Solution {

import java.util.*;

public class Solution {
    public int powSum(int n) {
        Set<Integer> seen = new HashSet<>();
        return dfs(n, 1, seen);
    }

    private int dfs(int n, int start, Set<Integer> seen) {
        if (n == 0) {
            return 1;
        }
        int count = 0;
        for (int i = start; i * i <= n; i++) {
            if (!seen.contains(i)) {
                seen.add(i);
                count += dfs(n - i * i, i + 1, seen);
                seen.remove(i);
            }
        }
        return count;
    }
}
}