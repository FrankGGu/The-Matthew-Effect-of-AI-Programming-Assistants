class Solution {
public:
    int largestPalindrome(int n, int k) {
        if (n == 1) return 9;

        long upper = pow(10, n) - 1;
        long lower = pow(10, n - 1);

        for (long i = upper; i >= lower; i--) {
            long palindrome = createPalindrome(i);
            if (palindrome < lower) break;
            if (palindrome % k == 0) return palindrome % 1337;
        }

        return 0;
    }

    long createPalindrome(long num) {
        string s = to_string(num);
        string rev(s.rbegin(), s.rend());
        return stoll(s + rev);
    }
};