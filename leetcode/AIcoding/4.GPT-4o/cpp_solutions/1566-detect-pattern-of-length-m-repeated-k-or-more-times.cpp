class Solution {
public:
    bool containsPattern(string s, int m, int k) {
        int n = s.size();
        for (int i = 0; i <= n - m * k; ++i) {
            string pattern = s.substr(i, m);
            int count = 0;
            for (int j = i; j <= n - m; j += m) {
                if (s.substr(j, m) == pattern) {
                    count++;
                    if (count >= k) return true;
                } else {
                    break;
                }
            }
        }
        return false;
    }
};