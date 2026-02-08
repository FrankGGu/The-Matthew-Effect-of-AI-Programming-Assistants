public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> result = new ArrayList<>();
        backtrack(1, new ArrayList<>(), n, k, result);
        return result;
    }

    private void backtrack(int start, List<Integer> current, int n, int k, List<List<Integer>> result) {
        if (current.size() == k) {
            result.add(new ArrayList<>(current));
            return;
        }
        for (int i = start; i <= n; i++) {
            current.add(i);
            backtrack(i + 1, current, n, k, result);
            current.remove(current.size() - 1);
        }
    }
}
}