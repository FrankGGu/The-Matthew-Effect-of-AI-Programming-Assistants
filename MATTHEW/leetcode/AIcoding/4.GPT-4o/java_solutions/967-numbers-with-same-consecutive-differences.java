import java.util.ArrayList;
import java.util.List;

public class Solution {
    public int[] numsSameConsecDiff(int n, int k) {
        List<Integer> result = new ArrayList<>();
        if (n == 1) {
            for (int i = 0; i < 10; i++) {
                result.add(i);
            }
        } else {
            for (int i = 1; i < 10; i++) {
                dfs(result, i, n - 1, k);
            }
        }
        return result.stream().mapToInt(i -> i).toArray();
    }

    private void dfs(List<Integer> result, int num, int n, int k) {
        if (n == 0) {
            result.add(num);
            return;
        }
        int lastDigit = num % 10;
        if (lastDigit + k < 10) {
            dfs(result, num * 10 + lastDigit + k, n - 1, k);
        }
        if (k > 0 && lastDigit - k >= 0) {
            dfs(result, num * 10 + lastDigit - k, n - 1, k);
        }
    }
}