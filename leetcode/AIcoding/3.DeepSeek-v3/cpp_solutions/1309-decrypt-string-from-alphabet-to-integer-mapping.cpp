class Solution {
public:
    string freqAlphabets(string s) {
        string res;
        int n = s.size();
        for (int i = 0; i < n; ) {
            if (i + 2 < n && s[i + 2] == '#') {
                int num = (s[i] - '0') * 10 + (s[i + 1] - '0');
                res += 'a' + num - 1;
                i += 3;
            } else {
                res += 'a' + (s[i] - '0') - 1;
                i += 1;
            }
        }
        return res;
    }
};