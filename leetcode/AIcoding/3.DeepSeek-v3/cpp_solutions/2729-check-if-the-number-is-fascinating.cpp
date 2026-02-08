class Solution {
public:
    bool isFascinating(int n) {
        string s = to_string(n) + to_string(2 * n) + to_string(3 * n);
        if (s.size() != 9) return false;
        unordered_set<char> seen;
        for (char c : s) {
            if (c == '0' || seen.count(c)) return false;
            seen.insert(c);
        }
        return true;
    }
};