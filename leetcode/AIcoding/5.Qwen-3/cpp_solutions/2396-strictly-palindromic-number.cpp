#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool isStrictlyPalindromic(int n) {
        for (int base = 2; base <= n - 1; ++base) {
            string s;
            int num = n;
            while (num > 0) {
                s += to_string(num % base);
                num /= base;
            }
            int left = 0, right = s.length() - 1;
            while (left < right) {
                if (s[left] != s[right]) {
                    return false;
                }
                ++left;
                --right;
            }
        }
        return true;
    }
};