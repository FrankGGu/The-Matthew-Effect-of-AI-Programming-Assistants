#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int maxNumOfSubstrings(string s) {
        int n = s.length();
        vector<int> left(n, -1), right(n, -1);

        for (int i = 0; i < n; ++i) {
            int l = i, r = i;
            while (l >= 0 && r < n && s[l] == s[r]) {
                left[r] = l;
                right[l] = r;
                --l;
                ++r;
            }
        }

        for (int i = 0; i < n; ++i) {
            int l = i, r = i + 1;
            while (l >= 0 && r < n && s[l] == s[r]) {
                left[r] = l;
                right[l] = r;
                --l;
                ++r;
            }
        }

        vector<int> dp(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            if (left[i] != -1) {
                dp[i + 1] = max(dp[i], dp[left[i]] + 1);
            } else {
                dp[i + 1] = dp[i];
            }
        }

        return dp[n];
    }
};