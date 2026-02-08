import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<List<Integer>> findStableArrays(int n) {
        List<List<Integer>> result = new ArrayList<>();
        backtrack(result, new ArrayList<>(), n, 0);
        return result;
    }

    private void backtrack(List<List<Integer>> result, List<Integer> tempList, int n, int start) {
        if (tempList.size() == n) {
            if (isStable(tempList)) {
                result.add(new ArrayList<>(tempList));
            }
            return;
        }
        for (int i = start; i <= 1; i++) {
            tempList.add(i);
            backtrack(result, tempList, n, 0);
            tempList.remove(tempList.size() - 1);
        }
    }

    private boolean isStable(List<Integer> arr) {
        int n = arr.size();
        for (int i = 1; i < n; i++) {
            if (arr.get(i) == arr.get(i - 1)) {
                return false;
            }
            if (i > 1 && arr.get(i) == arr.get(i - 2)) {
                return false;
            }
        }
        return true;
    }
}