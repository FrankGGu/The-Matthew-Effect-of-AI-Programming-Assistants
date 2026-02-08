public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<List<Integer>> combinationSum3(int k, int n) {
        List<List<Integer>> result = new ArrayList<>();
        backtrack(1, new ArrayList<>(), result, k, n);
        return result;
    }

    private void backtrack(int start, List<Integer> path, List<List<Integer>> result, int k, int target) {
        if (path.size() == k) {
            if (target == 0) {
                result.add(new ArrayList<>(path));
            }
            return;
        }

        for (int i = start; i <= 9; i++) {
            if (i > target) break;
            path.add(i);
            backtrack(i + 1, path, result, k, target - i);
            path.remove(path.size() - 1);
        }
    }
}
}