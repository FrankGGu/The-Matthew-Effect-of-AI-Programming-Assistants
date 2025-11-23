public class Solution {

import java.util.*;

public class Solution {
    public List<String> braceExpansionII(String expression) {
        List<String> result = new ArrayList<>();
        dfs(expression, 0, new StringBuilder(), result);
        Collections.sort(result);
        return result;
    }

    private void dfs(String expr, int index, StringBuilder path, List<String> result) {
        if (index == expr.length()) {
            result.add(path.toString());
            return;
        }

        char c = expr.charAt(index);
        if (c == '{') {
            int end = findClosingBrace(expr, index);
            String[] options = expr.substring(index + 1, end).split("\\+");
            for (String option : options) {
                path.append(option);
                dfs(expr, end + 1, path, result);
                path.delete(path.length() - option.length(), path.length());
            }
        } else if (c == '}') {
            return;
        } else {
            path.append(c);
            dfs(expr, index + 1, path, result);
            path.deleteCharAt(path.length() - 1);
        }
    }

    private int findClosingBrace(String expr, int start) {
        int count = 0;
        for (int i = start; i < expr.length(); i++) {
            if (expr.charAt(i) == '{') count++;
            if (expr.charAt(i) == '}') {
                count--;
                if (count == 0) return i;
            }
        }
        return -1;
    }
}
}