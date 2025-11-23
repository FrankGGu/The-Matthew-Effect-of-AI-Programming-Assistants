class Solution {
public:
    int countKSubsequences(string s, int k) {
        unordered_map<char, int> freq;
        for (char c : s) freq[c]++;

        vector<int> counts;
        for (auto& [ch, count] : freq) {
            counts.push_back(count);
        }

        sort(counts.rbegin(), counts.rend());

        long long total = 1, mod = 1e9 + 7;
        for (int i = 0; i < k; i++) {
            if (i >= counts.size()) return 0;
            total = (total * counts[i]) % mod;
        }

        return total;
    }
};