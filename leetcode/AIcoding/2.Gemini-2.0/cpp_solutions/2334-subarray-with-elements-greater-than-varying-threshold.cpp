#include <vector>

using namespace std;

class Solution {
public:
    int validSubarraySize(vector<int>& nums, int threshold) {
        int n = nums.size();
        vector<int> left(n, 0), right(n, 0);
        vector<int> stack;

        for (int i = 0; i < n; ++i) {
            while (!stack.empty() && nums[stack.back()] >= nums[i]) {
                stack.pop_back();
            }
            left[i] = stack.empty() ? 0 : stack.back() + 1;
            stack.push_back(i);
        }

        stack.clear();
        for (int i = n - 1; i >= 0; --i) {
            while (!stack.empty() && nums[stack.back()] >= nums[i]) {
                stack.pop_back();
            }
            right[i] = stack.empty() ? n - 1 : stack.back() - 1;
            stack.push_back(i);
        }

        for (int i = 0; i < n; ++i) {
            int len = right[i] - left[i] + 1;
            if (nums[i] > (double)threshold / len) {
                return len;
            }
        }

        return -1;
    }
};