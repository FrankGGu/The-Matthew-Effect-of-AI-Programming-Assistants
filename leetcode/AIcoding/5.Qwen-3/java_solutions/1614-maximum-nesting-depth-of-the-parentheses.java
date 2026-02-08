public class Solution {
    public int maxDepth(string s) {
        int depth = 0;
        int max = 0;
        for (char c : s.toCharArray()) {
            if (c == '(') {
                depth++;
                if (depth > max) {
                    max = depth;
                }
            } else if (c == ')') {
                depth--;
            }
        }
        return max;
    }
}