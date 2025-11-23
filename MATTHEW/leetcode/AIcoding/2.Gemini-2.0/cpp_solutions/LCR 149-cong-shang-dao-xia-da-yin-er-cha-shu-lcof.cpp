#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> recordLight(vector<vector<int>>& lights) {
        vector<vector<int>> result;
        for (auto& light : lights) {
            if (result.empty() || light[0] > result.back()[1]) {
                result.push_back(light);
            } else {
                result.back()[1] = max(result.back()[1], light[1]);
            }
        }
        return result;
    }
};