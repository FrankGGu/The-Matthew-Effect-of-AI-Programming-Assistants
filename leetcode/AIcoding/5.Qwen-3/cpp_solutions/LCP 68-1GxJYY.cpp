#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minFlips(int a, int b, int c) {
        int flips = 0;
        for (int i = 0; i < 32; ++i) {
            bool bitA = (a >> i) & 1;
            bool bitB = (b >> i) & 1;
            bool bitC = (c >> i) & 1;

            if (bitC) {
                if (!bitA && !bitB) {
                    flips += 2;
                }
            } else {
                if (bitA && bitB) {
                    flips += 2;
                } else if (bitA || bitB) {
                    flips += 1;
                }
            }
        }
        return flips;
    }
};