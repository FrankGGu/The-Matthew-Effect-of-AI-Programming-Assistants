public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> magickPermutation(int n) {
        List<List<Integer>> result = new ArrayList<>();
        boolean[] used = new boolean[n + 1];
        backtrack(n, new ArrayList<>(), used, result);
        return result;
    }

    private void backtrack(int n, List<Integer> current, boolean[] used, List<List<Integer>> result) {
        if (current.size() == n) {
            result.add(new ArrayList<>(current));
            return;
        }
        for (int i = 1; i <= n; i++) {
            if (!used[i]) {
                if (current.isEmpty() || (i + current.get(current.size() - 1)) % 2 == 1) {
                    used[i] = true;
                    current.add(i);
                    backtrack(n, current, used, result);
                    current.remove(current.size() - 1);
                    used[i] = false;
                }
            }
        }
    }
}
}