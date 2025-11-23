#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int numSubseq(vector<int>& nums, vector<int>& target) {
        int n = nums.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] > target[0]) break;
            for (int j = i + 1; j < n; ++j) {
                if (nums[i] + nums[j] > target[1]) break;
                for (int k = j + 1; k < n; ++k) {
                    if (nums[i] + nums[j] + nums[k] > target[2]) break;
                    for (int l = k + 1; l < n; ++l) {
                        if (nums[i] + nums[j] + nums[k] + nums[l] > target[3]) break;
                        for (int m = l + 1; m < n; ++m) {
                            if (nums[i] + nums[j] + nums[k] + nums[l] + nums[m] > target[4]) break;
                            count++;
                        }
                    }
                }
            }
        }
        return count;
    }
};