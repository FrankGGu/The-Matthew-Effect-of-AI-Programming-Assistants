class Solution {
public:
    string deepDarkFraction(int n) {
        if (n == 0) return "0";
        string result = "";
        while (n > 0) {
            int digit = n % 10;
            result = to_string(digit) + result;
            n /= 10;
        }
        return result;
    }
};