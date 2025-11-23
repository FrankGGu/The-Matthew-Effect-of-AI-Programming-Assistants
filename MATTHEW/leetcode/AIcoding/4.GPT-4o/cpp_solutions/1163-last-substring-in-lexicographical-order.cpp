class Solution {
public:
    string lastSubstring(string s) {
        int n = s.size();
        int maxIndex = n - 1;
        for (int i = n - 2; i >= 0; --i) {
            if (s[i] > s[maxIndex]) {
                maxIndex = i;
            } else if (s[i] == s[maxIndex]) {
                int j = 1;
                while (i + j < n && maxIndex + j < n && s[i + j] == s[maxIndex + j]) {
                    j++;
                }
                if (i + j < n && (maxIndex + j >= n || s[i + j] > s[maxIndex + j])) {
                    maxIndex = i;
                }
            }
        }
        return s.substr(maxIndex);
    }
};