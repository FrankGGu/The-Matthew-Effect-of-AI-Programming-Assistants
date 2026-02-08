#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> getStrongest(std::vector<int>& arr, int k) {
        std::sort(arr.begin(), arr.end());
        int n = arr.size();
        int median = arr[(n - 1) / 2];
        std::vector<int> result;

        std::vector<std::pair<int, int>> strength;
        for (int num : arr) {
            strength.emplace_back(std::abs(num - median), num);
        }

        std::sort(strength.rbegin(), strength.rend());

        for (int i = 0; i < k; ++i) {
            result.push_back(strength[i].second);
        }

        return result;
    }
};