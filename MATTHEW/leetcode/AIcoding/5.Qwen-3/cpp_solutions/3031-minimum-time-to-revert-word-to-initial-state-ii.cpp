#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minimumTimeToRevertToInitialState(string s, int k) {
        int n = s.length();
        vector<int> lps(n, 0);
        for (int i = 1; i < n; ++i) {
            int j = lps[i - 1];
            while (j > 0 && s[i] != s[j]) {
                j = lps[j - 1];
            }
            if (s[i] == s[j]) {
                j++;
            }
            lps[i] = j;
        }

        int maxPrefix = lps[n - 1];
        int steps = (n + k - 1) / k;
        if (maxPrefix >= n - k) {
            return steps - 1;
        }
        return steps;
    }
};