class Solution {
public:
    vector<string> getWordsInLongestSubsequence(int n, vector<string>& words, vector<int>& groups) {
        vector<string> result;
        int prev_group = -1;
        for (int i = 0; i < n; ++i) {
            if (groups[i] != prev_group) {
                result.push_back(words[i]);
                prev_group = groups[i];
            }
        }
        return result;
    }
};