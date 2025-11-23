#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> findBeautifulIndices(std::vector<int>& nums, int k) {
        std::vector<int> result;
        std::vector<int> indices;

        for (int i = 0; i < nums.size(); ++i) {
            indices.push_back(i);
        }

        std::sort(indices.begin(), indices.end(), [&](int a, int b) {
            return nums[a] < nums[b];
        });

        int n = indices.size();
        for (int i = 0; i < n; ++i) {
            bool isBeautiful = true;
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                if (std::abs(indices[i] - indices[j]) <= k) {
                    isBeautiful = false;
                    break;
                }
            }
            if (isBeautiful) {
                result.push_back(indices[i]);
            }
        }

        return result;
    }
};