#include <vector>
#include <numeric>

class Solution {
public:
    int minOperations(std::vector<int>& nums, int k) {
        std::vector<bool> seen(k + 1, false);
        int collected_count = 0;
        int operations = 0;

        for (int i = nums.size() - 1; i >= 0; --i) {
            operations++;
            int num = nums[i];
            if (num >= 1 && num <= k && !seen[num]) {
                seen[num] = true;
                collected_count++;
            }
            if (collected_count == k) {
                return operations;
            }
        }
        return operations; 
    }
};