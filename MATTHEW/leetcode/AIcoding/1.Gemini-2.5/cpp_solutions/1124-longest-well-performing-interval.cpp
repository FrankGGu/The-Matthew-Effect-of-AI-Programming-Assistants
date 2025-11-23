#include <vector>
#include <numeric>
#include <map>
#include <algorithm>

class Solution {
public:
    int longestWellPerformingInterval(std::vector<int>& hours) {
        int n = hours.size();

        // prefix_sum[i] will store the sum of arr[0]...arr[i-1]
        // arr[j] = 1 if hours[j] > 8, else -1
        // We want to find max(j - i + 1) such that sum(arr[i]...arr[j]) > 0
        // sum(arr[i]...arr[j]) = prefix_sum[j+1] - prefix_sum[i]
        // So we need prefix_sum[j+1] - prefix_sum[i] > 0
        // Which means prefix_sum[j+1] > prefix_sum[i]

        // Map to store the first occurrence of each prefix sum value.
        // Key: prefix sum value, Value: index in the prefix sum array
        // (i.e., if prefix_sum[k] = val, then map[val] = k)
        std::map<int, int> first_occurrence;

        // Initialize with prefix_sum[0] = 0 at index 0.
        // This represents an empty prefix before any elements.
        first_occurrence[0] = 0; 

        int max_len = 0;
        int current_sum = 0; // Represents prefix_sum[k] for the current iteration k

        for (int k = 1; k <= n; ++k) {
            // Calculate the current element's contribution
            int val = (hours[k-1] > 8) ? 1 : -1;
            current_sum += val; // This is prefix_sum[k]

            // If current_sum is positive, the interval from the beginning (index 0)
            // up to the current element (index k-1) is well-performing.
            // Its sum is current_sum - prefix_sum[0] = current_sum - 0 = current_sum > 0.
            // Length is k - 0 = k.
            if (current_sum > 0) {
                max_len = std::max(max_len, k);
            }

            // If current_sum is not positive, we need to find a previous prefix sum `P_i`
            // such that `P_i < current_sum`.
            // To maximize the length `k - i`, we need to minimize `i`.
            // The smallest `i` for which `P_i < current_sum` is achieved when `P_i`
            // is the largest possible value strictly less than `current_sum`.
            // Since the prefix sums change by +/-1, the largest value strictly less than
            // `current_sum` is `current_sum - 1`.
            // We look up `current_sum - 1` in our map. If it exists, `first_occurrence[current_sum - 1]`
            // gives the smallest index `i` where this sum occurred.
            // The interval from `i` to `k-1` (inclusive) has sum `current_sum - (current_sum - 1) = 1 > 0`.
            // Its length is `k - i`.
            else { // current_sum <= 0
                if (first_occurrence.count(current_sum - 1)) {
                    max_len = std::max(max_len, k - first_occurrence[current_sum - 1]);
                }
            }

            // Store the first occurrence of the current_sum.
            // We only store the first occurrence to ensure `i` is minimized for a given sum.
            if (first_occurrence.find(current_sum) == first_occurrence.end()) {
                first_occurrence[current_sum] = k;
            }
        }

        return max_len;
    }
};