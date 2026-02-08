#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    long long countSubstrings(string s) {
        int n = s.length();
        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                long long num = 0;
                for (int k = i; k <= j; ++k) {
                    num = num * 10 + (s[k] - '0');
                }
                if (num == 0) {
                    ans++;
                } else if (num % (s[j] - '0' ) == 0) {
                    ans++;
                }
            }
        }
        return ans;
    }
};