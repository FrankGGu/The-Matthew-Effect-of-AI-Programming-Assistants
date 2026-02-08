class Solution {
public:
    int findFirstAlmostEqualSubstring(string s) {
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (abs(s[i] - s[j]) == 1) {
                    return i;
                }
            }
        }
        return -1;
    }
};