class Solution {
public:
    bool canConstruct(string s, string t) {
        vector<int> count(26, 0);
        for (char c : t) {
            count[c - 'a']++;
        }
        for (char c : s) {
            if (--count[c - 'a'] < 0) {
                return false;
            }
        }
        return true;
    }
};