import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> generateStrings(int n) {
        List<String> result = new ArrayList<>();
        if (n == 0) {
            return result;
        }
        char[] current = new char[n];
        backtrack(0, n, current, result);
        return result;
    }

    private void backtrack(int index, int n, char[] current, List<String> result) {
        if (index == n) {
            result.add(new String(current));
            return;
        }

        current[index] = '1';
        backtrack(index + 1, n, current, result);

        if (index == 0 || current[index - 1] == '1') {
            current[index] = '0';
            backtrack(index + 1, n, current, result);
        }
    }
}