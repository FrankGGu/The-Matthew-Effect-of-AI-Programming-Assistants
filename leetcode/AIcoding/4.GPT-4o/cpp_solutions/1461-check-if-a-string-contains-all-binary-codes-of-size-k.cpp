class Solution {
public:
    bool hasAllCodes(string s, int k) {
        unordered_set<string> seen;
        int total = 1 << k; // 2^k

        for (int i = 0; i <= s.size() - k; ++i) {
            seen.insert(s.substr(i, k));
            if (seen.size() == total) {
                return true;
            }
        }
        return false;
    }
};