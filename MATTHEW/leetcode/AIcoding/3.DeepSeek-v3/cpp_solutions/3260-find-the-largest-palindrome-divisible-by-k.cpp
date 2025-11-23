class Solution {
public:
    int largestPalindrome(int n) {
        if (n == 1) return 9;
        int upper = pow(10, n) - 1;
        int lower = pow(10, n - 1);
        for (int i = upper; i >= lower; --i) {
            long palindrome = buildPalindrome(i);
            for (long j = upper; j * j >= palindrome; --j) {
                if (palindrome % j == 0 && palindrome / j <= upper) {
                    return palindrome % 1337;
                }
            }
        }
        return -1;
    }

private:
    long buildPalindrome(int n) {
        string s = to_string(n);
        string rev = s;
        reverse(rev.begin(), rev.end());
        return stol(s + rev);
    }
};