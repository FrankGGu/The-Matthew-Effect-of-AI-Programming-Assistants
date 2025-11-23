using namespace std;

class Solution {
public:
    int largestPalindrome(int n) {
        if (n == 1) return 9;
        long long upper = pow(10, n) - 1;
        long long lower = pow(10, n - 1);
        for (long long i = upper; i >= lower; i--) {
            long long palindrome = createPalindrome(i);
            for (long long j = upper; j * j >= palindrome; j--) {
                if (palindrome % j == 0 && palindrome / j >= lower && palindrome / j <= upper) {
                    return palindrome % 1337;
                }
            }
        }
        return 0;
    }

private:
    long long createPalindrome(long long num) {
        string s = to_string(num);
        string rs = s;
        reverse(rs.begin(), rs.end());
        return stoll(s + rs);
    }
};