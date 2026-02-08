import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> lexicalOrder(int n) {
        List<Integer> result = new ArrayList<>();
        dfs(1, n, result);
        return result;
    }

    private void dfs(int curr, int n, List<Integer> result) {
        if (curr > n) return;
        result.add(curr);
        dfs(curr * 10, n, result);
        if (curr % 10 != 9) {
            dfs(curr + 1, n, result);
        }
    }
}