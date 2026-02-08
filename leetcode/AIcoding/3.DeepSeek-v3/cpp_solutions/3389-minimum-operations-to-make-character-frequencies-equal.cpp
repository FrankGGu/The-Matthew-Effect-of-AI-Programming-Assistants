class Solution {
public:
    int minOperations(string s) {
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        int res = 0;
        while (true) {
            unordered_set<int> unique;
            bool allEqual = true;
            int minFreq = INT_MAX;
            int maxFreq = 0;

            for (int i = 0; i < 26; ++i) {
                if (freq[i] == 0) continue;
                unique.insert(freq[i]);
                minFreq = min(minFreq, freq[i]);
                maxFreq = max(maxFreq, freq[i]);
            }

            if (unique.size() <= 1) break;

            for (int i = 0; i < 26; ++i) {
                if (freq[i] == maxFreq) {
                    freq[i]--;
                    res++;
                    break;
                }
            }
        }

        return res;
    }
};