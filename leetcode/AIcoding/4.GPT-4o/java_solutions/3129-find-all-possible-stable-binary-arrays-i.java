import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<List<Integer>> stableBinaryArrays(int n) {
        List<List<Integer>> result = new ArrayList<>();
        backtrack(result, new ArrayList<>(), n, 0);
        return result;
    }

    private void backtrack(List<List<Integer>> result, List<Integer> tempList, int n, int index) {
        if (tempList.size() == n) {
            result.add(new ArrayList<>(tempList));
            return;
        }
        for (int i = index; i < n; i++) {
            tempList.add(i % 2);
            backtrack(result, tempList, n, i + 1);
            tempList.remove(tempList.size() - 1);
        }
    }
}