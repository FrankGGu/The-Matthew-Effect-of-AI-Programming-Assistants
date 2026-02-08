class Solution {
public:
    bool isSubsequence(const string& a, const string& b) {
        int i = 0, j = 0;
        while (i < a.size() && j < b.size()) {
            if (a[i] == b[j]) {
                i++;
            }
            j++;
        }
        return i == a.size();
    }

    int findLUSlength(vector<string>& strs) {
        int max_len = -1;
        for (int i = 0; i < strs.size(); ++i) {
            bool is_valid = true;
            for (int j = 0; j < strs.size(); ++j) {
                if (i != j && isSubsequence(strs[i], strs[j])) {
                    is_valid = false;
                    break;
                }
            }
            if (is_valid) {
                max_len = max(max_len, static_cast<int>(strs[i].size()));
            }
        }
        return max_len;
    }
};