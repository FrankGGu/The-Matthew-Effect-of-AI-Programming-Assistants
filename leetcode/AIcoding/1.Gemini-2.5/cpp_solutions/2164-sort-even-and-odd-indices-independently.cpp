#include <vector>
#include <algorithm>
#include <functional>

class Solution {
public:
    std::vector<int> sortEvenOdd(std::vector<int>& nums) {
        if (nums.empty()) {
            return {};
        }

        std::vector<int> even_indexed_elements;
        std::vector<int> odd_indexed_elements;

        for (int i = 0; i < nums.size(); ++i) {
            if (i % 2 == 0) {
                even_indexed_elements.push_back(nums[i]);
            } else {
                odd_indexed_elements.push_back(nums[i]);
            }
        }

        std::sort(even_indexed_elements.begin(), even_indexed_elements.end());
        std::sort(odd_indexed_elements.begin(), odd_indexed_elements.end(), std::greater<int>());

        int even_ptr = 0;
        int odd_ptr = 0;

        for (int i = 0; i < nums.size(); ++i) {
            if (i % 2 == 0) {
                nums[i] = even_indexed_elements[even_ptr++];
            } else {
                nums[i] = odd_indexed_elements[odd_ptr++];
            }
        }

        return nums;
    }
};