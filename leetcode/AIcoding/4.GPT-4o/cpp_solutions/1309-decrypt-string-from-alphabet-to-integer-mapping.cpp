class Solution {
public:
    string freqAlphabets(string s) {
        string result;
        for (int i = s.size() - 1; i >= 0; ) {
            if (s[i] == '#') {
                int num = (s[i - 2] - '0') * 10 + (s[i - 1] - '0');
                result += char('a' + num - 1);
                i -= 3;
            } else {
                result += char('a' + (s[i] - '1'));
                i--;
            }
        }
        reverse(result.begin(), result.end());
        return result;
    }
};