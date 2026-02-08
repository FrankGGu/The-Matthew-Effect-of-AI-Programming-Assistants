import java.util.ArrayList;
import java.util.List;

class Solution {
    List<List<Integer>> result;
    int N;
    int K;

    public List<List<Integer>> combine(int n, int k) {
        result = new ArrayList<>();
        N = n;
        K = k;
        backtrack(new ArrayList<>(), 1);
        return result;
    }

    private void backtrack(List<Integer> currentCombination, int startNum) {
        if (currentCombination.size() == K) {
            result.add(new ArrayList<>(currentCombination));
            return;
        }

        int remainingNeeded = K - currentCombination.size();
        int maxPossibleStart = N - remainingNeeded + 1;

        for (int i = startNum; i <= maxPossibleStart; i++) {
            currentCombination.add(i);
            backtrack(currentCombination, i + 1);
            currentCombination.remove(currentCombination.size() - 1);
        }
    }
}