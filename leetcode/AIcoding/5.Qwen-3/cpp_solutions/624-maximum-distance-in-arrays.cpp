#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maxDistance(vector<vector<int>>& arrays) {
        int min_val = INT_MAX;
        int max_val = INT_MIN;
        int result = 0;
        for (const auto& arr : arrays) {
            if (!arr.empty()) {
                result = max(result, abs(arr.back() - min_val));
                result = max(result, abs(max_val - arr.front()));
                min_val = min(min_val, arr.front());
                max_val = max(max_val, arr.back());
            }
        }
        return result;
    }
};