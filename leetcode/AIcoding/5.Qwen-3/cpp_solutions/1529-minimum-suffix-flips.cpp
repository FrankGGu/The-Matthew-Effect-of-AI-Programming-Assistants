#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minSuffixFlips(string s) {
        int flips = 0;
        char last = '0';
        for (char c : s) {
            if (c != last) {
                flips++;
                last = c;
            }
        }
        return flips;
    }
};