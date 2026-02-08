class Solution {
public:
    int findLUSlength(vector<string>& strs) {
        int maxLength = -1;
        for (int i = 0; i < strs.size(); ++i) {
            bool isSubsequence = false;
            for (int j = 0; j < strs.size(); ++j) {
                if (i != j && isSubsequenceOf(strs[i], strs[j])) {
                    isSubsequence = true;
                    break;
                }
            }
            if (!isSubsequence) {
                maxLength = max(maxLength, (int)strs[i].length());
            }
        }
        return maxLength;
    }

private:
    bool isSubsequenceOf(const string& a, const string& b) {
        int m = a.length(), n = b.length();
        int j = 0;
        for (int i = 0; i < n && j < m; ++i) {
            if (a[j] == b[i]) {
                ++j;
            }
        }
        return j == m;
    }
};