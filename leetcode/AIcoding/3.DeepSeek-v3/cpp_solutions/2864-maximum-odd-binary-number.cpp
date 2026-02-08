class Solution {
public:
    string maximumOddBinaryNumber(string s) {
        int count = 0;
        for (char c : s) {
            if (c == '1') {
                count++;
            }
        }
        string res(s.size(), '0');
        if (count > 0) {
            res.back() = '1';
            count--;
        }
        for (int i = 0; i < count; i++) {
            res[i] = '1';
        }
        return res;
    }
};