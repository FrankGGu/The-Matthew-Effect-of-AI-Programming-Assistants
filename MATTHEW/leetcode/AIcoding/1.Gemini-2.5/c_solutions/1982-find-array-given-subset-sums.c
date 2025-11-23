#include <stdlib.h> // Required for malloc, free, qsort in pure C
#include <string.h> // Required for memcpy, memset in pure C
#include <math.h>   // Required for log2
#include <stdio.h>  // For debugging, can be removed

#include <vector>     // For std::vector
#include <algorithm>  // For std::sort
#include <set>        // For std::multiset
#include <cmath>      // For std::log2
#include <numeric>    // For std::iota (not used here but often useful)

class Solution {
public:
    std::vector<int> findArray(std::vector<int>& sums) {
        // Sort the initial sums array. This is crucial as the algorithm relies on
        // finding the smallest and second smallest sums.
        std::sort(sums.begin(), sums.end());

        // Calculate 'n', the number of elements in the original array 'nums'.
        // The number of subset sums is 2^n.
        int n = std::log2(sums.size());

        // 'ans' will store the reconstructed elements of 'nums'.
        std::vector<int> ans;

        // 'current_sums' will be a multiset holding the subset sums at each step.
        // It's initialized with the given 'sums'.
        std::multiset<int> current_sums(sums.begin(), sums.end());

        // We iterate 'n' times, extracting one element of 'nums' in each iteration.
        for (int i = 0; i < n; ++i) {
            // The difference between the smallest and second smallest sum in 'current_sums'
            // is a candidate for the next element 'x'.
            // This 'x' represents |element| or element itself.
            int x = *std::next(current_sums.begin()) - *current_sums.begin();
            ans.push_back(x);

            // 'next_sums' will store the subset sums for the remaining (n-1-i) elements.
            std::multiset<int> next_sums;

            // Iterate through 'current_sums' to partition it into two sets:
            // 1. Sums that do not include 'x' (these go into 'next_sums').
            // 2. Sums that do include 'x' (these are 's_val + x' and are removed).
            for (auto it = current_sums.begin(); it != current_sums.end(); ) {
                int s_val = *it;
                // Remove 's_val' from 'current_sums' and add it to 'next_sums'.
                // This 's_val' is assumed to be a sum from the subset not including 'x'.
                it = current_sums.erase(it);
                next_sums.insert(s_val);

                // If 's_val' is a sum from the subset not including 'x', then 's_val + x'
                // must be a sum from the subset that *does* include 'x'.
                // Find and remove 's_val + x' from 'current_sums'.
                auto target_it = current_sums.find(s_val + x);
                current_sums.erase(target_it);
            }
            // Update 'current_sums' for the next iteration.
            current_sums = next_sums;

            // Crucial step: Determine the correct sign for 'x'.
            // The set of sums for any array of numbers must always contain 0 (for the empty subset).
            // If 'current_sums' (which now holds sums for the remaining elements) does not contain 0,
            // it means the 'x' we just extracted was actually '-x' in the original 'nums' array.
            if (current_sums.count(0) == 0) {
                // Correct the sign of the last added element in 'ans'.
                ans.back() *= -1;

                // If 'x' was actually '-x', then the 'current_sums' we derived (by removing 's' and 's+x')
                // are all effectively shifted by 'x' relative to what they should be.
                // To get the true sums for the remaining elements, we need to shift them back by '-x'.
                std::multiset<int> temp_shifted_sums;
                for (int val : current_sums) {
                    temp_shifted_sums.insert(val - x);
                }
                current_sums = temp_shifted_sums;
            }
        }
        return ans;
    }
};