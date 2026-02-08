#include <vector>
#include <numeric>
#include <algorithm>
#include <set>

long long kadane(const std::vector<int>& arr) {
    if (arr.empty()) {
        return 0;
    }

    long long max_so_far = -2e18; // Initialize with a very small number, smaller than any possible single element
    long long current_max = 0;
    int max_val = arr[0]; // To handle the case where all numbers in the array are negative
    bool has_positive = false;

    for (int x : arr) {
        if (x > 0) {
            has_positive = true;
        }
        max_val = std::max(max_val, x); // Keep track of the largest single element

        current_max += x;
        max_so_far = std::max(max_so_far, current_max);
        if (current_max < 0) {
            current_max = 0;
        }
    }

    // If all numbers in the array are non-positive (including zeros),
    // and max_so_far is 0 (due to current_max being reset),
    // the true maximum subarray sum is the largest (least negative) single element.
    // If there are positive numbers, max_so_far will correctly capture the sum.
    if (!has_positive && max_so_far <= 0) {
        return max_val; 
    }

    return max_so_far;
}

class Solution {
public:
    long long maximumSubarraySum(std::vector<int>& nums) {
        std::set<int> unique_elements;
        for (int num : nums) {
            unique_elements.insert(num);
        }

        // Initialize overall_max_sum to 0. This handles cases where removing an element
        // results in an empty array (sum 0) or an array of only negative numbers
        // where 0 (empty subarray) is the best option.
        long long overall_max_sum = 0; 

        for (int x_to_remove : unique_elements) {
            std::vector<int> temp_nums;
            temp_nums.reserve(nums.size()); // Optimize memory allocation
            for (int num : nums) {
                if (num != x_to_remove) {
                    temp_nums.push_back(num);
                }
            }
            overall_max_sum = std::max(overall_max_sum, kadane(temp_nums));
        }

        return overall_max_sum;
    }
};