#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int reductionOperations(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int operations = 0;
        int n = nums.size();
        for (int i = n - 1; i > 0; --i) {
            if (nums[i] != nums[i - 1]) {
                operations += (n - i);
            }
        }
        return operations;
    }
};