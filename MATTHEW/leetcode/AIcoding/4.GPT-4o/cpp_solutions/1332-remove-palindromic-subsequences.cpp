class Solution {
public:
    int removePalindromeSub(string s) {
        return s == string(s.rbegin(), s.rend()) ? 1 : 2;
    }
};