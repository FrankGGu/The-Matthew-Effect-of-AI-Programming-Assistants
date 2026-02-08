#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string nearestPalindromic(string n) {
        long long num = stoll(n);
        int len = n.length();

        if (num <= 10) {
            return to_string(num - 1);
        }

        string prefix = n.substr(0, (len + 1) / 2);
        long long p = stoll(prefix);

        long long candidates[] = {
            (long long)pow(10, len - 1) - 1,
            (long long)pow(10, len) + 1,
            createPalindrome(to_string(p - 1), len % 2 == 0),
            createPalindrome(to_string(p), len % 2 == 0),
            createPalindrome(to_string(p + 1), len % 2 == 0)
        };

        long long ans = -1;
        long long diff = LLONG_MAX;

        for (long long candidate : candidates) {
            if (candidate == num) continue;

            long long curDiff = abs(candidate - num);

            if (curDiff < diff) {
                diff = curDiff;
                ans = candidate;
            } else if (curDiff == diff) {
                ans = min(ans, candidate);
            }
        }

        return to_string(ans);
    }

private:
    long long createPalindrome(string prefix, bool even) {
        string suffix = prefix;
        reverse(suffix.begin(), suffix.end());

        if (!even) {
            prefix.pop_back();
        }

        return stoll(prefix + suffix);
    }
};