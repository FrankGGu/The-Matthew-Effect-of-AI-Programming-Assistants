class Solution {
public:
    int largestPalindrome(int n) {
        if (n == 1) return 9;
        long upper = pow(10, n) - 1;
        long lower = pow(10, n - 1);
        for (long i = upper; i >= lower; --i) {
            string s = to_string(i);
            string rev(s.rbegin(), s.rend());
            long palin = stol(s + rev);
            for (long j = upper; j * j >= palin; --j) {
                if (palin % j == 0 && palin / j <= upper) {
                    return palin % 1337;
                }
            }
        }
        return -1;
    }
};