class Solution {
public:
    int minDeletions(string s) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        unordered_set<int> seen;
        int deletions = 0;

        for (auto& [c, count] : freq) {
            while (count > 0 && seen.find(count) != seen.end()) {
                count--;
                deletions++;
            }
            if (count > 0) {
                seen.insert(count);
            }
        }

        return deletions;
    }
};