#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumSubtractionOperations(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int operations = 0;
        int last = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] > last) {
                operations += nums[i] - last;
                last = nums[i];
            }
        }
        return operations;
    }
};