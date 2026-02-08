#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, vector<int>& x, vector<int>& y) {
        int n = nums.size();
        int res = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == x[i]) continue;
            if (nums[i] == y[i]) {
                res++;
                swap(nums[i], x[i]);
            } else {
                return -1;
            }
        }
        return res;
    }
};