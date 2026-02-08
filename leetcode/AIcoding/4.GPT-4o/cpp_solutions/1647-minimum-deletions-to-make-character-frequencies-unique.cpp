class Solution {
public:
    int minDeletions(string s) {
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        sort(freq.rbegin(), freq.rend());

        int deletions = 0;
        for (int i = 1; i < 26; i++) {
            if (freq[i] == 0) break;
            if (freq[i] >= freq[i - 1]) {
                deletions += freq[i] - max(0, freq[i - 1] - 1);
                freq[i] = max(0, freq[i - 1] - 1);
            }
        }

        return deletions;
    }
};