#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numSubarraysWithAndK(vector<int>& nums, int k) {
        int count = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            int currentAnd = nums[i];
            if (currentAnd == k) {
                ++count;
            }
            for (int j = i + 1; j < n; ++j) {
                currentAnd &= nums[j];
                if (currentAnd == k) {
                    ++count;
                }
            }
        }
        return count;
    }
};