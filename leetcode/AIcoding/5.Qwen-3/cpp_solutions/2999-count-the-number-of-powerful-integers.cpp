#include <iostream>
#include <vector>
#include <unordered_set>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> powerfulIntegers(int x, int y, int z) {
        unordered_set<int> result;
        for (int i = 0; i <= z; ++i) {
            for (int j = 0; j <= z; ++j) {
                int val = pow(x, i) + pow(y, j);
                if (val <= z) {
                    result.insert(val);
                }
            }
        }
        return vector<int>(result.begin(), result.end());
    }
};