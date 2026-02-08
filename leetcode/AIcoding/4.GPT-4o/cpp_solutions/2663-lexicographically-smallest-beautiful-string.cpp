class Solution {
public:
    string smallestBeautifulString(string s, int k) {
        int n = s.size();
        vector<char> result(n);
        for (int i = n - 1; i >= 0; --i) {
            if (s[i] < 'a' + k - 1) {
                result[i] = s[i] + 1;
                for (int j = i + 1; j < n; ++j) {
                    result[j] = 'a';
                }
                break;
            }
            result[i] = 'a';
        }
        if (result[0] == 0) return "";
        for (int i = 1; i < n; ++i) {
            if (result[i] == 'a') continue;
            if (result[i] == result[i - 1] || (i > 1 && result[i] == result[i - 2])) {
                return "";
            }
        }
        return string(result.begin(), result.end());
    }
};