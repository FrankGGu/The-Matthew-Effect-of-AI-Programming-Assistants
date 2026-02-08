import java.util.*;

class Solution {
    public List<String> removeInvalidParentheses(String s) {
        Set<String> result = new HashSet<>();
        int[] count = countInvalid(s);
        dfs(s, count[0], count[1], 0, new StringBuilder(), result);
        return new ArrayList<>(result);
    }

    private int[] countInvalid(String s) {
        int left = 0, right = 0;
        for (char c : s.toCharArray()) {
            if (c == '(') left++;
            else if (c == ')') {
                if (left > 0) left--;
                else right++;
            }
        }
        return new int[]{left, right};
    }

    private void dfs(String s, int left, int right, int index, StringBuilder path, Set<String> result) {
        if (left == 0 && right == 0) {
            if (isValid(s)) {
                result.add(path.toString());
            }
            return;
        }
        for (int i = index; i < s.length(); i++) {
            if (i > index && s.charAt(i) == s.charAt(i - 1)) continue;
            if (left > 0 && s.charAt(i) == '(') {
                dfs(s.substring(0, i) + s.substring(i + 1), left - 1, right, i, path, result);
            }
            if (right > 0 && s.charAt(i) == ')') {
                dfs(s.substring(0, i) + s.substring(i + 1), left, right - 1, i, path, result);
            }
        }
    }

    private boolean isValid(String s) {
        int count = 0;
        for (char c : s.toCharArray()) {
            if (c == '(') count++;
            else if (c == ')') count--;
            if (count < 0) return false;
        }
        return count == 0;
    }
}