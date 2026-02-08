class Solution {
public:
    int scoreOfParentheses(string s) {
        int score = 0, depth = 0;
        for (char c : s) {
            if (c == '(') {
                depth++;
            } else {
                depth--;
                if (s[s.find(c) - 1] == '(') {
                    score += 1 << depth; // 2^depth
                }
            }
        }
        return score;
    }
};