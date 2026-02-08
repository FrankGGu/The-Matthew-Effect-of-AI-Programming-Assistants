#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCostToMakeArrayEqualindromic(vector<int>& nums) {
        int n = nums.size();
        vector<int> sorted_nums = nums;
        sort(sorted_nums.begin(), sorted_nums.end());

        auto isPalindrome = [](int x) {
            int rev = 0, original = x;
            while (x > 0) {
                rev = rev * 10 + x % 10;
                x /= 10;
            }
            return rev == original;
        };

        auto getCost = [&](int target) {
            int cost = 0;
            for (int num : nums) {
                cost += abs(num - target);
            }
            return cost;
        };

        int min_cost = INT_MAX;
        for (int i = 0; i < n; ++i) {
            int mid = sorted_nums[i];
            for (int j = 0; j <= 1; ++j) {
                int candidate = mid + j;
                if (isPalindrome(candidate)) {
                    min_cost = min(min_cost, getCost(candidate));
                }
            }
        }

        return min_cost;
    }
};