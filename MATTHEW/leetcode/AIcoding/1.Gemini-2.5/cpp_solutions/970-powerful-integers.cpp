#include <iostream>
#include <vector>
#include <set>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> powerfulIntegers(int x, int y, int bound) {
        set<int> result;
        for (int a = 1; a <= bound; a *= x) {
            for (int b = 1; a + b <= bound; b *= y) {
                result.insert(a + b);
                if (y == 1) break;
            }
            if (x == 1) break;
        }
        return vector<int>(result.begin(), result.end());
    }
};