#include <string>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    bool isPalindrome(long long n) {
        string s = to_string(n);
        string t = s;
        reverse(t.begin(), t.end());
        return s == t;
    }

    int superpalindromesInRange(string left, string right) {
        long long L = stoll(left);
        long long R = stoll(right);
        int count = 0;

        for (long long i = 1; i <= 100000; ++i) {
            string s = to_string(i);
            string t = s;
            reverse(t.begin(), t.end());
            string palindrome = s + t.substr(1);
            long long num = stoll(palindrome);
            long long sq = num * num;
            if (sq >= L && sq <= R && isPalindrome(sq)) {
                count++;
            }
        }

        for (long long i = 1; i <= 100000; ++i) {
            string s = to_string(i);
            string t = s;
            reverse(t.begin(), t.end());
            string palindrome = s + t;
            long long num = stoll(palindrome);
            long long sq = num * num;
            if (sq >= L && sq <= R && isPalindrome(sq)) {
                count++;
            }
        }

        return count;
    }
};