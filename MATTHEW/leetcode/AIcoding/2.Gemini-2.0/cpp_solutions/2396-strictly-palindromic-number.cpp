class Solution {
public:
    bool isStrictlyPalindromic(int n) {
        for (int base = 2; base <= n - 2; ++base) {
            string s = "";
            int num = n;
            while (num > 0) {
                s += to_string(num % base);
                num /= base;
            }
            string reversed_s = s;
            reverse(reversed_s.begin(), reversed_s.end());
            if (s != reversed_s) {
                return false;
            }
        }
        return true;
    }
};