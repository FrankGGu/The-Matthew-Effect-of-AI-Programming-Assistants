class Solution {
public:
    int maximumDeletions(string s) {
        int n = s.size();
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }
        sort(freq.rbegin(), freq.rend());

        int deletions = 0, current_max = INT_MAX;
        for (int f : freq) {
            if (f > 0) {
                if (f >= current_max) {
                    deletions += f - (current_max - 1);
                    current_max = max(0, current_max - 1);
                } else {
                    current_max = f;
                }
            }
        }
        return deletions;
    }
};