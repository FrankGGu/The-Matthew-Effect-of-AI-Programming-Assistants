#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minCostToEqualize(std::vector<int>& nums) {
        int n = nums.size();
        long long total = 0;
        for (int num : nums) {
            total += num;
        }
        long long avg = total / n;
        long long rem = total % n;
        long long cost = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] > avg) {
                cost += (nums[i] - avg);
            } else if (nums[i] < avg) {
                cost += (avg - nums[i]);
            }
        }
        return cost;
    }
};