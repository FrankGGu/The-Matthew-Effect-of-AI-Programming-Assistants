class Solution {
public:
    int minAddToMakeValid(string s) {
        int left = 0, right = 0;
        for (char c : s) {
            if (c == '(') {
                left++;
            } else {
                if (left > 0) {
                    left--;
                } else {
                    right++;
                }
            }
        }
        return left + right;
    }
};