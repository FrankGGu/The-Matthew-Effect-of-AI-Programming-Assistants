#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSum(int n, int k) {
        vector<int> nums;
        for (int i = 1; i <= n; ++i) {
            nums.push_back(i);
        }
        sort(nums.begin(), nums.end(), greater<int>());
        int sum = 0;
        for (int i = 0; i < k; ++i) {
            sum += nums[i];
        }
        return sum;
    }
};