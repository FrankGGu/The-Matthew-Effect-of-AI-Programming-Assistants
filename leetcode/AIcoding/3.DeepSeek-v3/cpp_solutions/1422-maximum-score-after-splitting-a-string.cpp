class Solution {
public:
    int maxScore(string s) {
        int max_score = 0;
        int zeros_left = 0;
        int ones_right = count(s.begin(), s.end(), '1');

        for (int i = 0; i < s.size() - 1; ++i) {
            if (s[i] == '0') {
                zeros_left++;
            } else {
                ones_right--;
            }
            max_score = max(max_score, zeros_left + ones_right);
        }

        return max_score;
    }
};