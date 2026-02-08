#include <vector>
#include <numeric>

class Solution {
public:
    bool checkArray(std::vector<int>& nums) {
        long long sum = 0;
        for (int num : nums) {
            sum += num;
        }
        return sum == 0;
    }
};