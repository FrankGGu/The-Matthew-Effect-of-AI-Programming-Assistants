#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largestPalindrome(int n) {
        if (n == 1) return 9;
        int upper = pow(10, n) - 1;
        int lower = pow(10, n - 1);
        for (int i = upper; i >= lower; --i) {
            string s = to_string(i);
            long long num = stoll(s + string(s.rbegin(), s.rend()));
            for (long long j = upper; j >= lower; --j) {
                if (num / j > upper) break;
                if (num % j == 0) return num % 1000000007;
            }
        }
        return -1;
    }
};