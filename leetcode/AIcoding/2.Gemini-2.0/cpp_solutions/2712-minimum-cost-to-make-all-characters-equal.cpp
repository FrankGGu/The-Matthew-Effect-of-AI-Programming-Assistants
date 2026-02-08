#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumCost(string s) {
        long long n = s.length();
        long long ans = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (s[i] != s[i + 1]) {
                ans += min((long long)i + 1, n - (long long)i - 1);
            }
        }
        return ans;
    }
};