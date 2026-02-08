class Solution {
public:
    long long countPrefixSuffixPairs(vector<string>& words) {
        long long res = 0;
        unordered_map<unsigned long long, int> freq;
        for (const string &word : words) {
            int n = word.size();
            unsigned long long prefixHash = 0, suffixHash = 0;
            for (int i = 0; i < n; ++i) {
                prefixHash = prefixHash * 131 + word[i];
                suffixHash = suffixHash * 131 + word[n - 1 - i];
                if (prefixHash == suffixHash) {
                    res += freq[prefixHash];
                }
            }
            freq[prefixHash]++;
        }
        return res;
    }
};