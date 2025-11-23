class Solution {
public:
    string largestGoodInteger(string num) {
        char maxDigit = '0';
        for (char c = '0'; c <= '9'; ++c) {
            if (count(num.begin(), num.end(), c) >= 3) {
                maxDigit = max(maxDigit, c);
            }
        }
        if (maxDigit == '0') return "";
        return string(3, maxDigit);
    }
};