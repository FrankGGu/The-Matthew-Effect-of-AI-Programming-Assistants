class Solution {
public:
    int countPalindromicSubsequence(string s) {
        vector<int> first(26, INT_MAX);
        vector<int> last(26, INT_MIN);

        for (int i = 0; i < s.size(); ++i) {
            int c = s[i] - 'a';
            first[c] = min(first[c], i);
            last[c] = max(last[c], i);
        }

        int res = 0;
        for (int c = 0; c < 26; ++c) {
            if (first[c] == INT_MAX || last[c] == INT_MIN) continue;
            unordered_set<char> unique;
            for (int i = first[c] + 1; i < last[c]; ++i) {
                unique.insert(s[i]);
            }
            res += unique.size();
        }
        return res;
    }
};