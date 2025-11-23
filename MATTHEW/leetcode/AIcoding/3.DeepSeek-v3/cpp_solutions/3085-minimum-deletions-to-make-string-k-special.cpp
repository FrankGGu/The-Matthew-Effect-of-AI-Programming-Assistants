class Solution {
public:
    int minimumDeletions(string word, int k) {
        unordered_map<char, int> freq;
        for (char c : word) {
            freq[c]++;
        }

        vector<int> counts;
        for (auto& [ch, cnt] : freq) {
            counts.push_back(cnt);
        }
        sort(counts.begin(), counts.end());

        int min_deletions = INT_MAX;
        int n = counts.size();

        for (int i = 0; i < n; ++i) {
            int target = counts[i];
            int deletions = 0;
            for (int j = 0; j < n; ++j) {
                if (counts[j] < target) {
                    deletions += counts[j];
                } else if (counts[j] > target + k) {
                    deletions += counts[j] - (target + k);
                }
            }
            min_deletions = min(min_deletions, deletions);
        }

        return min_deletions;
    }
};