class Solution {
public:
    int largestPalindrome(int n) {
        if (n == 1) return 9;
        long upper = pow(10, n) - 1;
        long lower = pow(10, n - 1);
        long maxPalindrome = 0;

        for (long i = upper; i >= lower; --i) {
            long palindrome = createPalindrome(i);
            for (long j = upper; j * j >= palindrome; --j) {
                if (palindrome % j == 0 && palindrome / j >= lower) {
                    maxPalindrome = max(maxPalindrome, palindrome % 1337);
                    break;
                }
            }
        }
        return maxPalindrome;
    }

    long createPalindrome(long half) {
        string s = to_string(half);
        string rev(s.rbegin(), s.rend());
        return stoll(s + rev);
    }
};