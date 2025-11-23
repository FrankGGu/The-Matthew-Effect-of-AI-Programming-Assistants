#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string largestGoodSubstring(string s) {
        int n = s.length();
        string result = "";
        for (int i = 2; i < n; ++i) {
            if (s[i] == s[i-1] && s[i] == s[i-2]) {
                if (result.empty() || s[i] > result[0]) {
                    result = s.substr(i-2, 3);
                }
            }
        }
        return result;
    }
};