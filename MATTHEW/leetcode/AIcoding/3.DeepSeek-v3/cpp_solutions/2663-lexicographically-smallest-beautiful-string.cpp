class Solution {
public:
    string smallestBeautifulString(string s, int k) {
        int n = s.size();
        for (int i = n - 1; i >= 0; --i) {
            for (char c = s[i] + 1; c < 'a' + k; ++c) {
                if ((i >= 1 && c == s[i - 1]) || (i >= 2 && c == s[i - 2])) {
                    continue;
                }
                string res = s;
                res[i] = c;
                for (int j = i + 1; j < n; ++j) {
                    for (char d = 'a'; d < 'a' + k; ++d) {
                        if ((j >= 1 && d == res[j - 1]) || (j >= 2 && d == res[j - 2])) {
                            continue;
                        }
                        res[j] = d;
                        break;
                    }
                }
                return res;
            }
        }
        return "";
    }
};