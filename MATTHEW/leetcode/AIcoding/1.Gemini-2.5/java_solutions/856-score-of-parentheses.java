class Solution {
    public int scoreOfParentheses(String s) {
        int score = 0;
        int balance = 0;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(') {
                balance++;
            } else { // c == ')'
                balance--;
                if (s.charAt(i - 1) == '(') {
                    score += (1 << balance);
                }
            }
        }
        return score;
    }
}