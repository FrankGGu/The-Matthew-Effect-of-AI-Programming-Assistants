class Solution {
public:
    int countPrefixSuffixPairs(vector<string>& words) {
        int count = 0;
        int n = words.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (isPrefixAndSuffix(words[i], words[j])) {
                    ++count;
                }
            }
        }
        return count;
    }

private:
    bool isPrefixAndSuffix(const string& a, const string& b) {
        if (a.size() > b.size()) {
            return false;
        }
        int m = a.size();
        int n = b.size();
        for (int i = 0; i < m; ++i) {
            if (a[i] != b[i]) {
                return false;
            }
        }
        for (int i = 0; i < m; ++i) {
            if (a[i] != b[n - m + i]) {
                return false;
            }
        }
        return true;
    }
};