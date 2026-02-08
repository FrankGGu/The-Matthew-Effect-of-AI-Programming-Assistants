class Solution {
public:
    string toHex(int num) {
        if (num == 0) return "0";
        string hex = "";
        unsigned int n = num;
        while (n > 0) {
            int rem = n % 16;
            hex = (rem < 10 ? char(rem + '0') : char(rem - 10 + 'a')) + hex;
            n /= 16;
        }
        return hex;
    }
};