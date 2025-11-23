#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largestOulier(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        sort(nums.begin(), nums.end());

        int n = nums.size();
        for (int i = n - 1; i >= 0; --i) {
            int target = nums[i] * 2;
            if (freq.find(target - nums[i]) != freq.end()) {
                if (target - nums[i] == nums[i]) {
                    if (freq[target - nums[i]] > 1) {
                        return nums[i];
                    }
                } else {
                    if (freq.find(target - nums[i]) != freq.end()) {
                        return nums[i];
                    }
                }
            }
        }

        return -1;
    }
};