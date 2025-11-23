#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    // Helper function to count subarrays with at most 'x' unique elements
    // This uses a sliding window approach.
    // Time complexity: O(N) on average due to unordered_map operations.
    // Space complexity: O(N) in worst case for unordered_map.
    long long countSubarraysWithAtMostXUnique(int x, const std::vector<int>& nums) {
        long long count = 0;
        int left = 0;
        std::unordered_map<int, int> freq;
        int current_unique_count = 0;

        for (int right = 0; right < nums.size(); ++right) {
            // Add nums[right] to the window
            freq[nums[right]]++;
            if (freq[nums[right]] == 1) {
                current_unique_count++;
            }

            // Shrink window from left if current_unique_count exceeds x
            while (current_unique_count > x) {
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    current_unique_count--;
                }
                left++;
            }

            // At this point, the window [left, right] has at most 'x' unique elements.
            // All subarrays ending at 'right' and starting from 'left' up to 'right'
            // (i.e., [left, right], [left+1, right], ..., [right, right])
            // also satisfy the condition. The number of such subarrays is (right - left + 1).
            count += (right - left + 1);
        }
        return count;
    }

    // Helper function to find the K-th smallest unique count among all subarrays.
    // This uses binary search on the answer (the unique count value).
    // The possible range for unique counts is [1, N].
    // Time complexity: O(log N * countSubarraysWithAtMostXUnique) = O(N log N) on average.
    double findKthSmallestUniqueCount(long long k_rank, int n_val, const std::vector<int>& nums) {
        int low = 1; // Minimum possible unique count in a subarray is 1.
        int high = n_val; // Maximum possible unique count in a subarray is n.
        double ans = n_val; // Initialize with a possible maximum value.

        while (low <= high) {
            int mid = low + (high - low) / 2;
            // If there are at least k_rank subarrays with 'mid' or fewer unique elements,
            // then 'mid' could be our answer, or we might find a smaller one.
            if (countSubarraysWithAtMostXUnique(mid, nums) >= k_rank) {
                ans = mid;
                high = mid - 1; // Try to find a smaller value.
            } else {
                // 'mid' is too small; we need more unique elements.
                low = mid + 1;
            }
        }
        return ans;
    }

    double medianOfUniquenessArray(std::vector<int>& nums) {
        long long n = nums.size();
        // Total number of subarrays in an array of size n is n * (n + 1) / 2.
        long long total_subarrays = n * (n + 1) / 2;

        // For the median of a sorted list of 'k' elements:
        // If 'k' is odd, it's the ((k+1)/2)-th smallest element.
        // If 'k' is even, it's the average of the (k/2)-th and ((k/2)+1)-th smallest elements.
        // The following calculation for rank1 and rank2 correctly handles both cases:
        // If total_subarrays is odd, rank1 = rank2, and we find the middle element.
        // If total_subarrays is even, rank2 = rank1 + 1, and we find the two middle elements.
        long long rank1 = (total_subarrays + 1) / 2;
        long long rank2 = (total_subarrays + 2) / 2;

        // Find the unique count value at rank1.
        double val1 = findKthSmallestUniqueCount(rank1, n, nums);
        // Find the unique count value at rank2.
        double val2 = findKthSmallestUniqueCount(rank2, n, nums);

        // The median is the average of these two values.
        return (val1 + val2) / 2.0;
    }
};