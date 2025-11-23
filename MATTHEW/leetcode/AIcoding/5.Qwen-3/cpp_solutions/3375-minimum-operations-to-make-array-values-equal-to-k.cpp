#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int operations = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] < k) {
                operations += (k - nums[i]);
            } else if (nums[i] > k) {
                operations += (nums[i] - k);
            }
        }
        return operations;
    }
};