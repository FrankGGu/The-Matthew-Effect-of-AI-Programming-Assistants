#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numberOfSubarrays(string s, vector<int>& pattern) {
        int n = s.length();
        int m = pattern.size();
        int count = 0;

        for (int i = 0; i <= n - m; ++i) {
            bool match = true;
            for (int j = 0; j < m; ++j) {
                if ((s[i + j] - '0') != pattern[j]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                ++count;
            }
        }

        return count;
    }
};