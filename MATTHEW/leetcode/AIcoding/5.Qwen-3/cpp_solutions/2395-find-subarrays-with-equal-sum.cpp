#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool isSumEqual(vector<int>& nums, int k) {
        int n = nums.size();
        if (k > n - 1) return false;
        unordered_set<int> sumSet;
        int currentSum = 0;
        for (int i = 0; i < k; ++i) {
            currentSum += nums[i];
        }
        sumSet.insert(currentSum);
        for (int i = k; i < n; ++i) {
            currentSum += nums[i] - nums[i - k];
            if (sumSet.find(currentSum) != sumSet.end()) {
                return true;
            }
            sumSet.insert(currentSum);
        }
        return false;
    }
};