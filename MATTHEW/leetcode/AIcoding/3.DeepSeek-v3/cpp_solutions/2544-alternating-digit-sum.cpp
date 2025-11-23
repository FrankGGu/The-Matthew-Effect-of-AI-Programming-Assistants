class Solution {
public:
    int alternateDigitSum(int n) {
        int sum = 0;
        int sign = 1;
        string numStr = to_string(n);
        for (char c : numStr) {
            int digit = c - '0';
            sum += sign * digit;
            sign *= -1;
        }
        return sum;
    }
};