import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> combinationSum3(int k, int n) {
        List<List<Integer>> result = new ArrayList<>();
        backtrack(k, n, 1, new ArrayList<>(), result);
        return result;
    }

    private void backtrack(int k, int n, int startNum, List<Integer> currentCombination, List<List<Integer>> result) {
        if (k == 0 && n == 0) {
            result.add(new ArrayList<>(currentCombination));
            return;
        }

        if (k == 0 || n < 0 || startNum > 9) {
            return;
        }

        for (int i = startNum; i <= 9; i++) {
            currentCombination.add(i);
            backtrack(k - 1, n - i, i + 1, currentCombination, result);
            currentCombination.remove(currentCombination.size() - 1);
        }
    }
}