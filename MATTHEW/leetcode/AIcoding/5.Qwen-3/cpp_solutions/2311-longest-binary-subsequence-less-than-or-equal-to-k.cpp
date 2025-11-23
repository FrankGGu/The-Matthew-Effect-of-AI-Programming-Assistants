#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string longestBinarySubsequenceLessThanEqualToK(string s, int k) {
        int n = s.length();
        vector<int> ones;
        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                ones.push_back(i);
            }
        }
        int m = ones.size();
        int len = 0;
        int val = 0;
        for (int i = 0; i < m; ++i) {
            int pos = ones[i];
            int bit = n - pos - 1;
            if (val + (1 << bit) <= k) {
                val += (1 << bit);
                len++;
            }
        }
        string res;
        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                if (len > 0) {
                    res += '1';
                    len--;
                }
            } else {
                res += '0';
            }
        }
        return res;
    }
};