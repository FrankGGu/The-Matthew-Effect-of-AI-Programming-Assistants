#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        sort(nums.begin(), nums.end());
        int mid = nums[n / 2];
        int operations = 0;
        for (int i = 0; i < n; ++i) {
            operations += abs(nums[i] - mid);
        }
        return operations;
    }
};