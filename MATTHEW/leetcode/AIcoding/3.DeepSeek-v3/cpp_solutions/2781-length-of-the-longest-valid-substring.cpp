class Solution {
public:
    int longestValidSubstring(string word, vector<string>& forbidden) {
        unordered_set<string> forbiddenSet(forbidden.begin(), forbidden.end());
        int maxLen = 0;
        int left = 0;
        int n = word.size();

        for (int right = 0; right < n; ++right) {
            for (int k = right; k >= left && k > right - 10; --k) {
                string current = word.substr(k, right - k + 1);
                if (forbiddenSet.count(current)) {
                    left = k + 1;
                    break;
                }
            }
            maxLen = max(maxLen, right - left + 1);
        }

        return maxLen;
    }
};