#include <string>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int largestPalindrome(int n, int k) {
        if (n == 1) {
            for (int p = 9; p >= 1; --p) {
                if (p % k == 0) {
                    return p % 1337;
                }
            }
            return 0;
        }

        long long upper_bound = 1;
        for (int i = 0; i < n; ++i) {
            upper_bound *= 10;
        }
        upper_bound--; 

        long long lower_bound = 1;
        for (int i = 0; i < n - 1; ++i) {
            lower_bound *= 10;
        }

        for (long long i = upper_bound; i >= lower_bound; --i) {
            long long palindrome = i;
            long long temp_i = i;

            while (temp_i > 0) {
                palindrome = palindrome * 10 + (temp_i % 10);
                temp_i /= 10;
            }

            if (palindrome % k != 0) {
                continue;
            }

            for (long long j = upper_bound; j * j >= palindrome; --j) {
                if (palindrome % j == 0) {
                    long long other_factor = palindrome / j;
                    if (other_factor >= lower_bound) { 
                        return palindrome % 1337;
                    }
                }
            }
        }
        return 0;
    }
};