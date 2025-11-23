class Solution {
public:
    int minInsertions(string s) {
        int ans = 0, right = 0;
        for (char c : s) {
            if (c == '(') {
                if (right % 2 == 1) {
                    ans++;
                    right--;
                }
                right += 2;
            } else {
                right--;
                if (right < 0) {
                    ans++;
                    right = 1;
                }
            }
        }
        return ans + right;
    }
};