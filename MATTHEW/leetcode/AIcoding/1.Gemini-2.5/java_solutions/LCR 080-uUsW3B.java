import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> currentCombination = new ArrayList<>();
        backtrack(n, k, 1, currentCombination, result);
        return result;
    }

    private void backtrack(int n, int k, int start, List<Integer> currentCombination, List<List<Integer>> result) {
        if (currentCombination.size() == k) {
            result.add(new ArrayList<>(currentCombination));
            return;
        }

        int remainingNeeded = k - currentCombination.size();
        // Optimization: The loop should only go up to a point where
        // there are enough numbers remaining (n - i + 1) to form the combination.
        // i <= n - (remainingNeeded) + 1
        for (int i = start; i <= n - remainingNeeded + 1; i++) {
            currentCombination.add(i);
            backtrack(n, k, i + 1, currentCombination, result);
            currentCombination.remove(currentCombination.size() - 1); // Backtrack
        }
    }
}