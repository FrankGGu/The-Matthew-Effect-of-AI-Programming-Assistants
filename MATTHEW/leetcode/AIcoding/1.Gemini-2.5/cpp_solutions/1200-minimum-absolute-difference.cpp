#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    std::vector<std::vector<int>> minimumAbsoluteDifference(std::vector<int>& arr) {
        std::sort(arr.begin(), arr.end());

        int min_diff = INT_MAX;
        for (size_t i = 0; i < arr.size() - 1; ++i) {
            min_diff = std::min(min_diff, arr[i+1] - arr[i]);
        }

        std::vector<std::vector<int>> result;
        for (size_t i = 0; i < arr.size() - 1; ++i) {
            if (arr[i+1] - arr[i] == min_diff) {
                result.push_back({arr[i], arr[i+1]});
            }
        }
        return result;
    }
};