#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestPalindrome(int n, int k) {
        if (n == 1) {
            if (k > 10) return "-1";
            if (k <= 9) return "9";
            return "-1";
        }

        long long upper = pow(10, n) - 1;
        long long lower = pow(10, n - 1);

        for (long long i = upper; i >= lower; --i) {
            string s = to_string(i);
            string reversed_s = s;
            reverse(reversed_s.begin(), reversed_s.end());
            long long palindrome = stoll(s + reversed_s.substr(0, n - 1));

            if (palindrome % k == 0) {
                return to_string(palindrome);
            }
        }

        return "-1";
    }
};