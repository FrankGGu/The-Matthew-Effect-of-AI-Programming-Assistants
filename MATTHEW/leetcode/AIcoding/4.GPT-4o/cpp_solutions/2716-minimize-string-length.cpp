class Solution {
public:
    int minimizedStringLength(string s) {
        unordered_set<char> uniqueChars(s.begin(), s.end());
        return uniqueChars.size();
    }
};