class Solution {
public:
    int minimumDeletions(string s, int k) {
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }
        sort(freq.rbegin(), freq.rend());
        int deletions = 0, total = 0;
        for (int i = 0; i < 26; ++i) {
            if (freq[i] == 0) break;
            total += freq[i];
            if (total > k) {
                deletions += total - k;
                total = k;
            }
        }
        return deletions;
    }
};