#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countValidPairs(string s) {
        int count = 0;
        for (int i = 0; i < s.length() - 1; ++i) {
            if (abs(s[i] - s[i+1]) == 1) {
                ++count;
            }
        }
        return count;
    }
};