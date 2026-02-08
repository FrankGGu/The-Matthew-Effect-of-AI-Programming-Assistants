class Solution {
public:
    int minimumDeletions(string s, int k) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }
        vector<int> counts;
        for (auto& p : freq) {
            counts.push_back(p.second);
        }
        sort(counts.begin(), counts.end());
        int minDeletions = INT_MAX;
        for (int i = 0; i < counts.size(); ++i) {
            int target = counts[i];
            int deletions = 0;
            for (int j = 0; j < counts.size(); ++j) {
                if (j < i) {
                    deletions += counts[j];
                } else if (counts[j] > target + k) {
                    deletions += counts[j] - (target + k);
                }
            }
            minDeletions = min(minDeletions, deletions);
        }
        return minDeletions;
    }
};