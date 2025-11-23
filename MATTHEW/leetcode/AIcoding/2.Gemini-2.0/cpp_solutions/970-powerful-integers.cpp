#include <vector>
#include <unordered_set>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> powerfulIntegers(int x, int y, int bound) {
        unordered_set<int> result_set;
        vector<int> result;

        for (int i = 0; pow(x, i) <= bound; ++i) {
            for (int j = 0; pow(y, j) <= bound; ++j) {
                int val = pow(x, i) + pow(y, j);
                if (val <= bound) {
                    result_set.insert(val);
                }
                if (y == 1) break;
            }
            if (x == 1) break;
        }

        for (int val : result_set) {
            result.push_back(val);
        }

        return result;
    }
};