#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int missingInteger(vector<int>& nums) {
        int n = nums.size();
        int prefix = nums[0];
        for (int i = 1; i < n; ++i) {
            if (nums[i] == prefix + 1) {
                prefix = nums[i];
            } else {
                break;
            }
        }
        int target = prefix + 1;
        while (true) {
            bool found = false;
            for (int num : nums) {
                if (num == target) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                return target;
            }
            target++;
        }
    }
};