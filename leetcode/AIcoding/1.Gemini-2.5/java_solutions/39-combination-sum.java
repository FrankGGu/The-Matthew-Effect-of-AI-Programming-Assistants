class Solution {
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        List<List<Integer>> result = new ArrayList<>();
        backtrack(candidates, target, 0, 0, new ArrayList<>(), result);
        return result;
    }

    private void backtrack(int[] candidates, int target, int currentSum, int startIndex,
                           List<Integer> currentCombination, List<List<Integer>> result) {
        if (currentSum == target) {
            result.add(new ArrayList<>(currentCombination));
            return;
        }

        if (currentSum > target) {
            return;
        }

        for (int i = startIndex; i < candidates.length; i++) {
            currentCombination.add(candidates[i]);
            backtrack(candidates, target, currentSum + candidates[i], i, currentCombination, result);
            currentCombination.remove(currentCombination.size() - 1);
        }
    }
}