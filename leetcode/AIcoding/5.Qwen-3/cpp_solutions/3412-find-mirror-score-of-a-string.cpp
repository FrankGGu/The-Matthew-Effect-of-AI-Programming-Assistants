#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int mirrorScore(string s) {
        int score = 0;
        int n = s.length();
        for (int i = 0; i < n / 2; ++i) {
            if (s[i] == s[n - 1 - i]) {
                ++score;
            }
        }
        return score;
    }
};