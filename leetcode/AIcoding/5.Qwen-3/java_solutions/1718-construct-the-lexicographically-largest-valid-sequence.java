public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> constructLargeNum(int n) {
        List<Integer> result = new ArrayList<>();
        boolean[] used = new boolean[n + 1];
        backtrack(n, used, new ArrayList<>(), result);
        return result;
    }

    private void backtrack(int n, boolean[] used, List<Integer> current, List<Integer> result) {
        if (current.size() == n) {
            result.clear();
            result.addAll(current);
            return;
        }
        for (int i = n; i >= 1; i--) {
            if (!used[i]) {
                if (current.isEmpty() || Math.abs(current.get(current.size() - 1) - i) == 1) {
                    used[i] = true;
                    current.add(i);
                    backtrack(n, used, current, result);
                    if (!result.isEmpty()) {
                        return;
                    }
                    current.remove(current.size() - 1);
                    used[i] = false;
                }
            }
        }
    }
}
}