#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numberOfSubarrays(string s, vector<int>& pattern) {
        int n = s.length();
        int m = pattern.size();
        vector<int> p(m);
        for (int i = 0; i < m; ++i) {
            p[i] = pattern[i];
        }

        vector<int> nums(n);
        for (int i = 0; i < n; ++i) {
            nums[i] = s[i] - '0';
        }

        vector<int> next(n + 1, 0);
        for (int i = 1; i < n; ++i) {
            int j = next[i];
            while (j > 0 && nums[i] != nums[j]) {
                j = next[j];
            }
            if (nums[i] == nums[j]) {
                ++j;
            }
            next[i + 1] = j;
        }

        int count = 0;
        int j = 0;
        for (int i = 0; i < n; ++i) {
            while (j > 0 && (nums[i] != p[j])) {
                j = next[j];
            }
            if (nums[i] == p[j]) {
                ++j;
            }
            if (j == m) {
                ++count;
                j = next[j];
            }
        }
        return count;
    }
};