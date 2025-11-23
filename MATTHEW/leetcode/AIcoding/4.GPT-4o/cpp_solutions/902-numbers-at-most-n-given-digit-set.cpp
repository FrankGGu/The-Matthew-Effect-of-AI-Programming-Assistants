class Solution {
public:
    int atMostNGivenDigitSet(vector<string>& digits, int n) {
        string s = to_string(n);
        int d = s.size(), m = digits.size();
        int res = 0;

        for (int i = 1; i < d; ++i) {
            res += pow(m, i);
        }

        for (int i = 0; i < d; ++i) {
            bool hasSame = false;
            for (const string& digit : digits) {
                if (digit[0] < s[i]) {
                    res += pow(m, d - i - 1);
                } else if (digit[0] == s[i]) {
                    hasSame = true;
                    break;
                }
            }
            if (!hasSame) {
                break;
            }
        }

        return res + 1;
    }
};