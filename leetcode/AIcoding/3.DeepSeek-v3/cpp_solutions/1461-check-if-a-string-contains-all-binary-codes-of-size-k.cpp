class Solution {
public:
    bool hasAllCodes(string s, int k) {
        if (s.size() < k) return false;
        unordered_set<string> codes;
        for (int i = 0; i <= s.size() - k; ++i) {
            codes.insert(s.substr(i, k));
        }
        return codes.size() == (1 << k);
    }
};