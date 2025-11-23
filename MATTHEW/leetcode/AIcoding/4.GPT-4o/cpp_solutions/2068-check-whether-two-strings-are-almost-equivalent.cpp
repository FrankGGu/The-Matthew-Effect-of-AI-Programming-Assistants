class Solution {
public:
    bool areAlmostEquivalent(string s1, string s2) {
        if (s1.length() != s2.length()) return false;
        int count[26] = {0};
        for (char c : s1) count[c - 'a']++;
        for (char c : s2) count[c - 'a']--;
        int diffCount = 0;
        for (int i : count) {
            if (i < 0) return false;
            diffCount += i > 1 ? i - 1 : 0;
        }
        return diffCount <= 2;
    }
};