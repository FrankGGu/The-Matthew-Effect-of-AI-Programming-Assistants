#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string applyOperations(string s) {
        int n = s.length();
        for (int i = 0; i < n - 1; ++i) {
            if (s[i] == s[i + 1]) {
                s[i] = '0';
                s[i + 1] = '0';
                i++;
            }
        }
        string result;
        for (char c : s) {
            if (c != '0') {
                result += c;
            }
        }
        return result;
    }
};