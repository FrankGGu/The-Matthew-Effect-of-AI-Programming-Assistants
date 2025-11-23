#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countGoodTriplets(vector<int>& nums, int a, int b, int c) {
        int n = nums.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (abs(nums[i] - nums[j]) > a) continue;
                for (int k = j + 1; k < n; ++k) {
                    if (abs(nums[j] - nums[k]) <= b && abs(nums[i] - nums[k]) <= c) {
                        ++count;
                    }
                }
            }
        }
        return count;
    }
};