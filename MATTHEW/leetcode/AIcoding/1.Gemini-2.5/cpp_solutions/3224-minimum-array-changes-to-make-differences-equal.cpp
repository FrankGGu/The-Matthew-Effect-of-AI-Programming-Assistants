#include <vector>
#include <algorithm>
#include <map>
#include <random>
#include <chrono>

class Solution {
public:
    int minChanges(std::vector<int>& nums) {
        int n = nums.size();

        if (n <= 2) {
            return 0;
        }

        // Initialize max_freq. For N >= 2, we can always choose two elements
        // to define an arithmetic progression, resulting in at least 2 matches.
        int max_freq = 2; 

        // Use a fixed seed for reproducibility on platforms like LeetCode.
        // For truly random behavior, use std::chrono::steady_clock::now().time_since_epoch().count().
        std::mt19937 rng(0); 

        std::uniform_int_distribution<int> dist(0, n - 1);

        // Number of iterations for the randomized algorithm.
        // A value around 100-200 is typically sufficient to find the optimal line
        // with high probability, especially if the optimal line contains a significant fraction of points.
        int R = 200; 

        for (int iter = 0; iter < R; ++iter) {
            int i = dist(rng);
            int j = dist(rng);

            // Ensure i and j are distinct indices
            while (i == j) {
                j = dist(rng);
            }

            // Calculate candidate common difference D
            // If nums[j] = A + j*D and nums[i] = A + i*D, then nums[j] - nums[i] = (j - i) * D
            // So, D = (nums[j] - nums[i]) / (j - i)
            long long diff_nums = (long long)nums[j] - nums[i];
            long long diff_indices = (long long)j - i;

            // D must be an integer (as elements are changed to integers)
            if (diff_nums % diff_indices == 0) {
                long long D = diff_nums / diff_indices;

                // Calculate candidate first term A
                // A = nums[i] - i * D
                long long A = (long long)nums[i] - (long long)i * D;

                // Count how many elements in the original array 'nums' would fit this arithmetic progression
                int current_freq = 0;
                for (int k = 0; k < n; ++k) {
                    // Check if nums[k] == A + k * D
                    if ((long long)nums[k] - (long long)k * D == A) {
                        current_freq++;
                    }
                }
                max_freq = std::max(max_freq, current_freq);
            }
        }

        // Special case: consider D = 0. This means all elements should be equal to some value A.
        // To maximize matches, A should be the mode of the original 'nums' array.
        // The randomized approach might not always find D=0 if all elements are distinct.
        std::map<int, int> zero_D_counts;
        int zero_D_max_freq = 0;
        for (int x : nums) {
            zero_D_counts[x]++;
            zero_D_max_freq = std::max(zero_D_max_freq, zero_D_counts[x]);
        }
        max_freq = std::max(max_freq, zero_D_max_freq);

        // The minimum number of changes is N minus the maximum number of elements that can form an AP.
        return n - max_freq;
    }
};