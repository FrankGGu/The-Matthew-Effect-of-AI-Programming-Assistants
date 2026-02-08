#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int mirrorReflection(int n, int m) {
        int h = m;
        int w = n;
        while (h % 2 == 0 && w % 2 == 0) {
            h /= 2;
            w /= 2;
        }
        if (h % 2 == 0 && w % 2 == 1) return 0;
        if (h % 2 == 1 && w % 2 == 0) return 1;
        return 2;
    }
};