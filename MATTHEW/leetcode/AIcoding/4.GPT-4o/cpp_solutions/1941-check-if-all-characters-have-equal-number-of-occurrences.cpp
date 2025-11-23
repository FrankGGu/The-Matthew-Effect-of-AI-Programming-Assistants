class Solution {
public:
    bool areOccurrencesEqual(string s) {
        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }
        int freq = count.begin()->second;
        for (const auto& entry : count) {
            if (entry.second != freq) {
                return false;
            }
        }
        return true;
    }
};