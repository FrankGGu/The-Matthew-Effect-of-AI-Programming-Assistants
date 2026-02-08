import java.util.ArrayList;
import java.util.List;

class Solution {
    List<Integer> result;
    int N;

    public List<Integer> lexicalOrder(int n) {
        result = new ArrayList<>();
        N = n;
        for (int i = 1; i <= 9; i++) {
            dfs(i);
        }
        return result;
    }

    private void dfs(int current) {
        if (current > N) {
            return;
        }
        result.add(current);
        for (int i = 0; i <= 9; i++) {
            int next = current * 10 + i;
            if (next <= N) {
                dfs(next);
            } else {
                break;
            }
        }
    }
}