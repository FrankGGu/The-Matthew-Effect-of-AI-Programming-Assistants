#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> numberOfBurgers(int totalHamburgers, int tomatoSlices, int cheeseSlices) {
        vector<vector<int>> result;
        int x = (tomatoSlices - 2 * cheeseSlices) / 2;
        int y = cheeseSlices - x;
        if (2 * x + 2 * y == totalHamburgers && 4 * x + 2 * y == tomatoSlices && x >= 0 && y >= 0) {
            result.push_back({x, y});
        }
        return result;
    }
};