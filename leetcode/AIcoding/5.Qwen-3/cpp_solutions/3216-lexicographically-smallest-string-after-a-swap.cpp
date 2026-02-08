#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string lexSmallestString(string s) {
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            if (s[i] != '0') {
                swap(s[i], s[0]);
                return s;
            }
        }
        return s;
    }
};