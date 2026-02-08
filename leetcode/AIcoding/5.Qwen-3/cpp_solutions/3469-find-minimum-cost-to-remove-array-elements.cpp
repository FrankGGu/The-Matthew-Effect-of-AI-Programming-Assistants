#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCostToRemoveArrayElements(vector<int>& nums, vector<int>& cost) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int n = nums.size();
        int total = 0;
        for (int i = 0; i < n; ++i) {
            total += cost[i];
        }

        int res = 0;
        for (int i = 0; i < n; ++i) {
            if (freq[nums[i]] == 1) {
                res += cost[i];
            }
        }

        return res;
    }
};