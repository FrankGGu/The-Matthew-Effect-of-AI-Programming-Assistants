#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> findSolution(CustomFunction& f, int z) {
        vector<vector<int>> result;
        for (int x = 1; x <= 1000; ++x) {
            for (int y = 1; y <= 1000; ++y) {
                if (f.f(x, y) == z) {
                    result.push_back({x, y});
                }
            }
        }
        return result;
    }
};