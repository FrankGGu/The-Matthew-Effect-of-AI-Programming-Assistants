import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<List<Integer>> findStableArrays(int n, int k) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> current = new ArrayList<>();
        solve(n, k, 0, current, result);
        return result;
    }

    private void solve(int n, int k, int sum, List<Integer> current, List<List<Integer>> result) {
        if (current.size() == n) {
            if (sum == k) {
                result.add(new ArrayList<>(current));
            }
            return;
        }

        current.add(0);
        solve(n, k, sum, current, result);
        current.remove(current.size() - 1);

        if (current.size() > 0 && current.get(current.size() - 1) == 1) return;

        current.add(1);
        solve(n, k, sum + 1, current, result);
        current.remove(current.size() - 1);
    }
}