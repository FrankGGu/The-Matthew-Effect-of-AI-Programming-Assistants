class Solution {
public:
    bool isSubstring(string s1, string s2) {
        return s1.find(s2) != string::npos;
    }

    bool isReverseSubstring(string s, string t) {
        string revT = string(t.rbegin(), t.rend());
        return isSubstring(s, revT);
    }

    bool isExist(string s, string t) {
        return isSubstring(s, t) || isReverseSubstring(s, t);
    }
};