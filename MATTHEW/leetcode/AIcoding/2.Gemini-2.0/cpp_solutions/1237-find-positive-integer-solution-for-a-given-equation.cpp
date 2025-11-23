#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> findSolution(CustomFunction& customfunction, int z) {
        vector<vector<int>> result;
        for (int x = 1; x <= 1000; ++x) {
            int low = 1, high = 1000;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                int val = customfunction.f(x, mid);
                if (val == z) {
                    result.push_back({x, mid});
                    break;
                } else if (val < z) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
        }
        return result;
    }
};