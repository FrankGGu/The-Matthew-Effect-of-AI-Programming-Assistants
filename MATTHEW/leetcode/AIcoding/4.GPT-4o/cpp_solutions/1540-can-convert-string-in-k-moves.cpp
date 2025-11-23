class Solution {
public:
    bool canConvert(string s, string t, int k) {
        if (s == t) return true;
        if (s.length() != t.length()) return false;

        unordered_set<char> uniqueChars;
        for (char c : s) uniqueChars.insert(c);

        if (uniqueChars.size() < 26) return true;

        return k >= s.length();
    }
};