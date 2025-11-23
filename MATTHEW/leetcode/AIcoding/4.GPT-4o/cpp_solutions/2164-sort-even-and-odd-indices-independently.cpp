#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> sortEvenOdd(std::vector<int>& nums) {
        std::vector<int> even, odd;
        for (int i = 0; i < nums.size(); ++i) {
            if (i % 2 == 0) even.push_back(nums[i]);
            else odd.push_back(nums[i]);
        }
        std::sort(even.begin(), even.end());
        std::sort(odd.rbegin(), odd.rend());
        for (int i = 0; i < even.size(); ++i) nums[i * 2] = even[i];
        for (int i = 0; i < odd.size(); ++i) nums[i * 2 + 1] = odd[i];
        return nums;
    }
};