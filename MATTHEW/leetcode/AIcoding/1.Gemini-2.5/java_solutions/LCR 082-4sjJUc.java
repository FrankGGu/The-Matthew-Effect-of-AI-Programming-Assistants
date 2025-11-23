import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<List<Integer>> combinationSum2(int[] candidates, int target) {
        List<List<Integer>> results = new ArrayList<>();
        Arrays.sort(candidates);
        backtrack(results, new ArrayList<>(), candidates, target, 0);
        return results;
    }

    private void backtrack(List<List<Integer>> results, List<Integer> currentCombination, int[] candidates, int remainingTarget, int startIndex) {
        if (remainingTarget == 0) {
            results.add(new ArrayList<>(currentCombination));
            return;
        }

        if (remainingTarget < 0) {
            return;
        }

        for (int i = startIndex; i < candidates.length; i++) {
            if (i > startIndex && candidates[i] == candidates[i - 1]) {
                continue; // Skip duplicates
            }

            if (candidates[i] > remainingTarget) {
                break; // Optimization: candidates array is sorted
            }

            currentCombination.add(candidates[i]);
            backtrack(results, currentCombination, candidates, remainingTarget - candidates[i], i + 1);
            currentCombination.remove(currentCombination.size() - 1);
        }
    }
}