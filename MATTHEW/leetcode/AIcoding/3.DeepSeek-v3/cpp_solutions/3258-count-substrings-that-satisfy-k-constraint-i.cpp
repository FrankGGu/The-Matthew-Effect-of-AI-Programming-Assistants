class Solution {
public:
    int countSubstrings(string s, int k) {
        int n = s.size();
        int res = 0;
        for (int i = 0; i < n; ++i) {
            unordered_map<char, int> freq;
            int distinct = 0;
            for (int j = i; j < n; ++j) {
                if (freq[s[j]] == 0) {
                    distinct++;
                }
                freq[s[j]]++;
                if (distinct >= k) {
                    res++;
                }
            }
        }
        return res;
    }
};