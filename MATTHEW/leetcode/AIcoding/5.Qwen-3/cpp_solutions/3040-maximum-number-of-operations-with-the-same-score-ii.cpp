#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxOperations(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return 0;

        unordered_map<int, int> count;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int sum = nums[i] + nums[j];
                count[sum]++;
            }
        }

        int max_ops = 0;
        for (auto& [sum, ops] : count) {
            max_ops = max(max_ops, ops);
        }

        return max_ops;
    }
};