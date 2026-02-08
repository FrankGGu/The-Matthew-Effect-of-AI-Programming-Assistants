class Solution {
public:
    int minimizedStringLength(string s) {
        unordered_set<char> uniqueChars;
        for (char c : s) {
            uniqueChars.insert(c);
        }
        return uniqueChars.size();
    }
};