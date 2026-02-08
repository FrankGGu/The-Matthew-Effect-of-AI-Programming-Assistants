import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> combinationSum3(int k, int n) {
        List<List<Integer>> result = new ArrayList<>();
        combinationSum3Helper(k, n, 1, new ArrayList<>(), result);
        return result;
    }

    private void combinationSum3Helper(int k, int n, int start, List<Integer> currentList, List<List<Integer>> result) {
        if (currentList.size() == k) {
            if (n == 0) {
                result.add(new ArrayList<>(currentList));
            }
            return;
        }

        for (int i = start; i <= 9; i++) {
            currentList.add(i);
            combinationSum3Helper(k, n - i, i + 1, currentList, result);
            currentList.remove(currentList.size() - 1);
        }
    }
}