#include <vector>
#include <map>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int maximumLength(std::vector<int>& nums) {
        std::map<long long, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        int max_len = 0;

        // Handle the special case of '1'
        // If 1 is in the subset, then all adjacent elements must also be 1 (1*1=1).
        // So, if 1 is chosen, the subset can only consist of 1s.
        if (counts.count(1)) {
            max_len = counts[1]; // The length is simply the count of 1s available.
            counts[1] = 0;       // Mark 1s as processed so they are not used in other chains.
        } else {
            // If no 1s are present, a single element subset (e.g., [x]) is always valid,
            // so the minimum possible length is 1 (assuming nums is not empty, which it isn't based on constraints).
            max_len = 1;
        }

        // Iterate through the map to find chains starting with numbers greater than 1.
        // For numbers > 1, if x is in the subset, then x*x must be the next element.
        // This implies all elements in the subset must be distinct (x < x*x for x > 1).
        // The subset will be of the form [k, k^2, k^4, k^8, ...].
        for (auto const& [num_val, freq] : counts) {
            if (num_val == 1 || freq == 0) {
                continue; // Already processed (1) or no instances left.
            }

            long long current_val = num_val;
            int current_chain_len = 0;

            // Follow the chain: current_val, current_val^2, current_val^4, ...
            while (counts.count(current_val) && counts[current_val] > 0) {
                current_chain_len += 1; // Add one instance of current_val to the chain.
                counts[current_val] = 0; // Mark current_val as used for this chain.
                                         // This prevents current_val from starting another chain
                                         // and ensures each distinct value is counted once per chain.

                // Check for potential overflow before squaring.
                // LLONG_MAX is approximately 9.22 x 10^18.
                // sqrt(LLONG_MAX) is approximately 3.037 x 10^9.
                // If current_val exceeds this, then current_val * current_val will overflow a long long.
                // The largest possible value in nums is 10^9.
                // If current_val is 10^9, then current_val * current_val = 10^18, which fits in long long.
                // If current_val becomes 10^18, the next square (10^18)^2 would overflow.
                // So, if current_val is already greater than sqrt(LLONG_MAX), its square will overflow.
                // The constant 3037000499LL is floor(sqrt(LLONG_MAX)).
                if (current_val > 3037000499LL) { 
                    break; 
                }

                current_val = current_val * current_val;
            }
            max_len = std::max(max_len, current_chain_len);
        }

        return max_len;
    }
};