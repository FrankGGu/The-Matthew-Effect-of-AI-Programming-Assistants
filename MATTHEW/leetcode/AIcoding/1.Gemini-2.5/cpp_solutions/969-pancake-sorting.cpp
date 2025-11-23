#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> pancakeSort(std::vector<int>& arr) {
        std::vector<int> result;
        int n = arr.size();

        for (int target_val = n; target_val >= 1; --target_val) {
            auto it = std::find(arr.begin(), arr.begin() + target_val, target_val);
            int idx = std::distance(arr.begin(), it);

            if (idx == target_val - 1) {
                continue;
            }

            if (idx != 0) {
                std::reverse(arr.begin(), arr.begin() + idx + 1);
                result.push_back(idx + 1);
            }

            std::reverse(arr.begin(), arr.begin() + target_val);
            result.push_back(target_val);
        }

        return result;
    }
};