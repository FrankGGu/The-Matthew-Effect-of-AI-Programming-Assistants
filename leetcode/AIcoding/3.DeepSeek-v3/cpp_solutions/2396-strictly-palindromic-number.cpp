class Solution {
public:
    bool isStrictlyPalindromic(int n) {
        for (int base = 2; base <= n - 2; ++base) {
            string s;
            int num = n;
            while (num > 0) {
                s += to_string(num % base);
                num /= base;
            }
            string rev = s;
            reverse(rev.begin(), rev.end());
            if (s != rev) {
                return false;
            }
        }
        return true;
    }
};