#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int operations = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] % k != 0) {
                operations += (k - nums[i] % k);
                nums[i] += (k - nums[i] % k);
            }
        }
        return operations;
    }
};