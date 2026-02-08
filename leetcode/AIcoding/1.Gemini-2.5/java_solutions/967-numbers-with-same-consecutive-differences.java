import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] numsSameConsecDiff(int n, int k) {
        List<Integer> results = new ArrayList<>();

        // The first digit cannot be 0 for n >= 2.
        // According to constraints, n is always >= 2.
        for (int i = 1; i <= 9; i++) {
            dfs(i, 1, n, k, results);
        }

        return results.stream().mapToInt(i -> i).toArray();
    }

    private void dfs(int currentNum, int count, int n, int k, List<Integer> results) {
        if (count == n) {
            results.add(currentNum);
            return;
        }

        int lastDigit = currentNum % 10;

        // Option 1: Add k to the last digit
        int nextDigit1 = lastDigit + k;
        if (nextDigit1 >= 0 && nextDigit1 <= 9) {
            dfs(currentNum * 10 + nextDigit1, count + 1, n, k, results);
        }

        // Option 2: Subtract k from the last digit
        // Avoid duplicate calls if k is 0, as nextDigit1 would be the same as nextDigit2.
        if (k != 0) {
            int nextDigit2 = lastDigit - k;
            if (nextDigit2 >= 0 && nextDigit2 <= 9) {
                dfs(currentNum * 10 + nextDigit2, count + 1, n, k, results);
            }
        }
    }
}