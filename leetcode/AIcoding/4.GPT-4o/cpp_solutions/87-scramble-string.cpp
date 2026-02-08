class Solution {
public:
    bool isScramble(string s1, string s2) {
        int n = s1.size();
        if (n != s2.size()) return false;
        if (s1 == s2) return true;

        vector<int> count(26, 0);
        for (int i = 0; i < n; ++i) {
            count[s1[i] - 'a']++;
            count[s2[i] - 'a']--;
        }
        for (int i = 0; i < 26; ++i) {
            if (count[i] != 0) return false;
        }

        for (int len = 1; len < n; ++len) {
            if (isScramble(s1.substr(0, len), s2.substr(0, len)) && 
                isScramble(s1.substr(len), s2.substr(len))) {
                return true;
            }
            if (isScramble(s1.substr(0, len), s2.substr(n - len)) && 
                isScramble(s1.substr(len), s2.substr(0, n - len))) {
                return true;
            }
        }
        return false;
    }
};