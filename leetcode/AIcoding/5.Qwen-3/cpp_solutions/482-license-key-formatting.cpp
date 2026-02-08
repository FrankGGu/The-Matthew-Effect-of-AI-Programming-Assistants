#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string licenseKeyFormatting(string s, int k) {
        string result;
        int count = 0;

        for (int i = s.size() - 1; i >= 0; --i) {
            if (s[i] != '-') {
                if (count > 0 && count % k == 0) {
                    result.push_back('-');
                }
                result.push_back(toupper(s[i]));
                ++count;
            }
        }

        reverse(result.begin(), result.end());
        return result;
    }
};