class Solution {
public:
    int scoreOfParentheses(string s) {
        int score = 0, depth = 0;
        for (char c : s) {
            if (c == '(') {
                depth++;
            } else {
                depth--;
                if (s[&c - &s[0] - 1] == '(') {
                    score += 1 << depth;
                }
            }
        }
        return score;
    }
};