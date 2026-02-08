class Solution {
public:
    string longestNewString(string s) {
        unordered_set<char> seen;
        string result;

        for (char c : s) {
            if (seen.find(c) == seen.end()) {
                result += c;
                seen.insert(c);
            }
        }

        return result;
    }
};