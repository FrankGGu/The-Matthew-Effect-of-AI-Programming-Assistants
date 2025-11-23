#include <vector>
#include <stack>
#include <algorithm>

class Solution {
public:
    bool validSubarraySize(std::vector<int>& nums, int k) {
        int n = nums.size();
        std::vector<int> left(n);
        std::vector<int> right(n);
        std::stack<int> s;

        // Calculate left boundary for each element (index of previous smaller element)
        // For an element nums[i], left[i] will be the index of the first element to its left
        // that is strictly smaller than nums[i]. If no such element, it's -1.
        for (int i = 0; i < n; ++i) {
            while (!s.empty() && nums[s.top()] >= nums[i]) {
                s.pop();
            }
            left[i] = s.empty() ? -1 : s.top();
            s.push(i);
        }

        // Clear stack for right boundary calculation
        while (!s.empty()) {
            s.pop();
        }

        // Calculate right boundary for each element (index of next smaller element)
        // For an element nums[i], right[i] will be the index of the first element to its right
        // that is strictly smaller than nums[i]. If no such element, it's n.
        for (int i = n - 1; i >= 0; --i) {
            while (!s.empty() && nums[s.top()] >= nums[i]) {
                s.pop();
            }
            right[i] = s.empty() ? n : s.top();
            s.push(i);
        }

        // For each element nums[i], consider it as the minimum of a potential subarray.
        // The largest such subarray where nums[i] is the minimum spans from (left[i] + 1) to (right[i] - 1).
        // Its length will be (right[i] - 1) - (left[i] + 1) + 1 = right[i] - left[i] - 1.
        // We need to check if nums[i] > k * length for this subarray.
        for (int i = 0; i < n; ++i) {
            long long current_min_val = nums[i]; // Use long long for comparison to avoid overflow
            long long length = right[i] - left[i] - 1;

            // The problem condition is min(nums[l...r]) > k * (r - l + 1).
            // Here, nums[i] is the minimum, and 'length' is (r - l + 1).
            // We compare current_min_val with k * length.
            // Cast k to long long before multiplication to prevent potential overflow.
            if (current_min_val > (long long)k * length) {
                return true;
            }
        }

        return false;
    }
};