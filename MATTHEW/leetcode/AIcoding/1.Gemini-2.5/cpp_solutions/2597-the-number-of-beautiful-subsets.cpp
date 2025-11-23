#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    int k_val;
    std::vector<int> nums_arr;
    std::vector<int> freq; 
    int count;

    void backtrack(int index) {
        if (index == nums_arr.size()) {
            count++;
            return;
        }

        // Option 1: Exclude nums_arr[index]
        backtrack(index + 1);

        // Option 2: Include nums_arr[index]
        bool can_include = true;
        if (nums_arr[index] - k_val >= 0 && freq[nums_arr[index] - k_val] > 0) {
            can_include = false;
        }

        if (can_include) {
            freq[nums_arr[index]]++;
            backtrack(index + 1);
            freq[nums_arr[index]]--;
        }
    }

    int beautifulSubsets(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());
        nums_arr = nums;
        k_val = k;
        freq.resize(1001, 0); 
        count = 0;

        backtrack(0);

        return count - 1; // Subtract 1 to exclude the empty subset
    }
};