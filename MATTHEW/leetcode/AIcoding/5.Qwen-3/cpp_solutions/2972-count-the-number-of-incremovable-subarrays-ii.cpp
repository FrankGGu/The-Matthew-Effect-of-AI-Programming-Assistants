#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfSubarrays(vector<int>& nums) {
        int n = nums.size();
        vector<int> prefix(n, 0);
        vector<int> suffix(n, 0);

        prefix[0] = 1;
        for (int i = 1; i < n; ++i) {
            if (nums[i] > nums[i - 1]) {
                prefix[i] = prefix[i - 1] + 1;
            } else {
                prefix[i] = 1;
            }
        }

        suffix[n - 1] = 1;
        for (int i = n - 2; i >= 0; --i) {
            if (nums[i] < nums[i + 1]) {
                suffix[i] = suffix[i + 1] + 1;
            } else {
                suffix[i] = 1;
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                bool valid = true;
                if (i > 0 && nums[i] <= nums[i - 1]) {
                    valid = false;
                }
                if (j < n - 1 && nums[j] >= nums[j + 1]) {
                    valid = false;
                }
                if (valid) {
                    ++result;
                }
            }
        }

        return result;
    }
};