import java.util.*;

public class Solution {
    public List<String> braceExpansionII(String expression) {
        Set<String> result = new TreeSet<>();
        backtrack(expression, 0, new StringBuilder(), result);
        return new ArrayList<>(result);
    }

    private void backtrack(String expression, int index, StringBuilder current, Set<String> result) {
        if (index == expression.length()) {
            result.add(current.toString());
            return;
        }

        char c = expression.charAt(index);
        if (c == '{') {
            int end = findClosingBrace(expression, index);
            String[] options = expression.substring(index + 1, end).split(",");
            for (String option : options) {
                int len = current.length();
                backtrack(expression, end + 1, current.append(option), result);
                current.setLength(len);
            }
        } else {
            current.append(c);
            backtrack(expression, index + 1, current, result);
        }
    }

    private int findClosingBrace(String expression, int start) {
        int count = 0;
        for (int i = start; i < expression.length(); i++) {
            if (expression.charAt(i) == '{') count++;
            if (expression.charAt(i) == '}') count--;
            if (count == 0) return i;
        }
        return -1; // should never reach here if the input is valid
    }
}