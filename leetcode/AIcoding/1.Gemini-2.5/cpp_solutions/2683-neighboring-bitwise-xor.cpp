#include <vector>
#include <numeric>

class Solution {
public:
    bool canBeDerived(std::vector<int>& derived) {
        int n = derived.size();

        // dp[original0_val][current_original_val]
        // Represents whether it's possible to have:
        // 1. original[0] = original0_val
        // 2. original[i] = current_original_val (where i is the current index in the loop)
        // 3. All conditions derived[k] = original[k] XOR original[k+1] for 0 <= k < i are satisfied.
        std::vector<std::vector<bool>> dp(2, std::vector<bool>(2, false));

        // Base case for i = 0 (representing original[0])
        // If original[0] is 0, then original[0] is 0.
        dp[0][0] = true;
        // If original[0] is 1, then original[0] is 1.
        dp[1][1] = true;

        // Iterate from i = 1 up to n-1 to build the original array values
        // dp will hold the state for original[i-1], and new_dp will compute for original[i]
        for (int i = 1; i < n; ++i) {
            std::vector<std::vector<bool>> new_dp(2, std::vector<bool>(2, false));
            int prev_derived_val = derived[i - 1]; // derived[i-1] = original[i-1] XOR original[i]

            // Try both possibilities for original[0] (original0_val)
            for (int original0_val = 0; original0_val <= 1; ++original0_val) {
                // Try both possibilities for original[i] (current_original_val)
                for (int current_original_val = 0; current_original_val <= 1; ++current_original_val) {
                    // We know original[i] = current_original_val
                    // From derived[i-1] = original[i-1] XOR original[i], we can find original[i-1]:
                    // original[i-1] = derived[i-1] XOR original[i]
                    int prev_original_val = prev_derived_val ^ current_original_val;

                    // If it was possible to reach original[i-1] = prev_original_val
                    // with original[0] = original0_val, then it's possible to reach
                    // original[i] = current_original_val with original[0] = original0_val.
                    new_dp[original0_val][current_original_val] = dp[original0_val][prev_original_val];
                }
            }
            dp = new_dp; // Update dp for the next iteration (dp now represents state for original[i])
        }

        // After the loop, dp holds the state for original[n-1].
        // Now, we need to check the final circular condition:
        // derived[n-1] = original[n-1] XOR original[0]

        int last_derived_val = derived[n - 1];

        // Case 1: Assume original[0] was 0
        // The condition becomes: last_derived_val = original[n-1] XOR 0
        // This implies original[n-1] must be equal to last_derived_val.
        // Check if dp[0][last_derived_val] is true (i.e., possible to have original[0]=0 and original[n-1]=last_derived_val)
        if (dp[0][last_derived_val]) {
            return true;
        }

        // Case 2: Assume original[0] was 1
        // The condition becomes: last_derived_val = original[n-1] XOR 1
        // This implies original[n-1] must be equal to last_derived_val XOR 1.
        // Check if dp[1][last_derived_val XOR 1] is true (i.e., possible to have original[0]=1 and original[n-1]=last_derived_val XOR 1)
        if (dp[1][last_derived_val ^ 1]) {
            return true;
        }

        // If neither case yields a valid original array, return false.
        return false;
    }
};