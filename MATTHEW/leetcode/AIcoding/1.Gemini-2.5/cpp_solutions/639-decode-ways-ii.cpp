#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int numDecodings(string s) {
        int n = s.length();
        long mod = 1e9 + 7;

        if (n == 0) {
            return 0;
        }

        long two_back = 1;
        long one_back;

        if (s[0] == '0') {
            one_back = 0;
        } else if (s[0] == '*') {
            one_back = 9;
        } else {
            one_back = 1;
        }

        if (n == 1) {
            return one_back;
        }

        for (int i = 1; i < n; ++i) {
            long current = 0;
            char c1 = s[i];
            char c2 = s[i - 1];

            if (c1 == '*') {
                current = (9 * one_back) % mod;
            } else if (c1 != '0') {
                current = one_back;
            }

            if (c2 == '1') {
                if (c1 == '*') {
                    current = (current + 9 * two_back) % mod;
                } else {
                    current = (current + two_back) % mod;
                }
            } else if (c2 == '2') {
                if (c1 == '*') {
                    current = (current + 6 * two_back) % mod;
                } else if (c1 >= '0' && c1 <= '6') {
                    current = (current + two_back) % mod;
                }
            } else if (c2 == '*') {
                if (c1 == '*') {
                    current = (current + 15 * two_back) % mod;
                } else if (c1 >= '0' && c1 <= '6') {
                    current = (current + 2 * two_back) % mod;
                } else {
                    current = (current + two_back) % mod;
                }
            }

            two_back = one_back;
            one_back = current;
        }

        return one_back;
    }
};