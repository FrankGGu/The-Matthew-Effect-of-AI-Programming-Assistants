#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int secondsToRemoveOccurrences(string s) {
        int n = s.length();
        int res = 0;
        int left = 0;
        for (int i = 0; i < n; ++i) {
            if (s[i] == '0') {
                left++;
            } else {
                res = max(res, left);
            }
        }
        return res;
    }
};