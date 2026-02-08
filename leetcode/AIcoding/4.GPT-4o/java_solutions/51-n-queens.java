import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<List<String>> solveNQueens(int n) {
        List<List<String>> result = new ArrayList<>();
        backtrack(result, new ArrayList<>(), n, 0);
        return result;
    }

    private void backtrack(List<List<String>> result, List<String> temp, int n, int row) {
        if (row == n) {
            result.add(new ArrayList<>(temp));
            return;
        }
        for (int col = 0; col < n; col++) {
            if (isValid(temp, row, col)) {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < n; i++) {
                    sb.append(i == col ? 'Q' : '.');
                }
                temp.add(sb.toString());
                backtrack(result, temp, n, row + 1);
                temp.remove(temp.size() - 1);
            }
        }
    }

    private boolean isValid(List<String> temp, int row, int col) {
        for (int i = 0; i < row; i++) {
            if (temp.get(i).charAt(col) == 'Q' || 
                (col - (row - i) >= 0 && temp.get(i).charAt(col - (row - i)) == 'Q') || 
                (col + (row - i) < temp.size() && temp.get(i).charAt(col + (row - i)) == 'Q')) {
                return false;
            }
        }
        return true;
    }
}