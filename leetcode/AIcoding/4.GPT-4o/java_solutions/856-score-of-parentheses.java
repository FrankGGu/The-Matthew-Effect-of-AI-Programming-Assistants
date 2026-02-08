class Solution {
    public int scoreOfParentheses(String s) {
        int score = 0, depth = 0;
        for (char c : s.toCharArray()) {
            if (c == '(') {
                depth++;
            } else {
                depth--;
                if (s.charAt(depth) == '(') {
                    score += 1 << depth;
                }
            }
        }
        return score;
    }
}