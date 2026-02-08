#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string maximumBinaryString(string s) {
        int n = s.size();
        vector<int> ones;
        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                ones.push_back(i);
            }
        }
        if (ones.empty()) {
            return s;
        }
        int k = ones.size();
        int first = ones[0];
        for (int i = 1; i < k; ++i) {
            if (ones[i] != ones[i - 1] + 1) {
                break;
            }
            first = ones[i];
        }
        string result = s;
        for (int i = 0; i < n; ++i) {
            if (i == first) {
                result[i] = '1';
            } else if (i < first) {
                result[i] = '0';
            } else if (i > first) {
                result[i] = '0';
            }
        }
        return result;
    }
};