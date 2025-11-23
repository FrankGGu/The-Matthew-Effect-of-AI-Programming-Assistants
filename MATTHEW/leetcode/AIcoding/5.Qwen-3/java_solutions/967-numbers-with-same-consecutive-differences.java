public class Solution {

import java.util.*;

public class Solution {
    public int[] numsSameConsecDiff(int n, int k) {
        Set<Integer> result = new HashSet<>();
        for (int i = 1; i <= 9; i++) {
            dfs(n, k, i, i, result);
        }
        int[] ans = new int[result.size()];
        int index = 0;
        for (int num : result) {
            ans[index++] = num;
        }
        Arrays.sort(ans);
        return ans;
    }

    private void dfs(int n, int k, int current, int last, Set<Integer> result) {
        if (n == 1) {
            result.add(current);
            return;
        }
        for (int d = 0; d <= 9; d++) {
            if (Math.abs(d - last) == k) {
                dfs(n - 1, k, current * 10 + d, d, result);
            }
        }
    }
}
}