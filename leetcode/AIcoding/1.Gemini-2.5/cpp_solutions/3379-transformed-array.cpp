#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> sortTransformedArray(std::vector<int>& nums, int a, int b, int c) {
        int n = nums.size();
        std::vector<int> result(n);

        auto f = [&](int x) {
            return a * x * x + b * x + c;
        };

        if (a == 0) {
            for (int i = 0; i < n; ++i) {
                result[i] = f(nums[i]);
            }
            if (b < 0) {
                std::reverse(result.begin(), result.end());
            }
            return result;
        }

        int left = 0, right = n - 1;

        if (a > 0) {
            int k = n - 1;
            while (left <= right) {
                int val_left = f(nums[left]);
                int val_right = f(nums[right]);
                if (val_left >= val_right) {
                    result[k--] = val_left;
                    left++;
                } else {
                    result[k--] = val_right;
                    right--;
                }
            }
        } else { // a < 0
            int k = 0;
            while (left <= right) {
                int val_left = f(nums[left]);
                int val_right = f(nums[right]);
                if (val_left <= val_right) {
                    result[k++] = val_left;
                    left++;
                } else {
                    result[k++] = val_right;
                    right--;
                }
            }
        }

        return result;
    }
};