#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::string largestNumber(std::vector<int>& cost, int target) {
        std::vector<std::string> dp(target + 1, "#"); // "#" signifies unreachable state
        dp[0] = ""; // Base case: cost 0 can form an empty number

        for (int i = 1; i <= target; ++i) {
            for (int j = 0; j < 9; ++j) { // Iterate through digits 1 to 9
                int current_cost = cost[j];
                char digit_char = (char)('1' + j);

                if (i >= current_cost) {
                    // Check if the subproblem (i - current_cost) is reachable
                    if (dp[i - current_cost] != "#") {
                        std::string candidate_str = dp[i - current_cost] + digit_char;

                        // If dp[i] is currently unreachable or candidate_str is longer
                        if (dp[i] == "#" || candidate_str.length() > dp[i].length()) {
                            dp[i] = candidate_str;
                        } 
                        // If lengths are equal, choose the lexicographically larger string
                        else if (candidate_str.length() == dp[i].length()) {
                            if (candidate_str > dp[i]) {
                                dp[i] = candidate_str;
                            }
                        }
                    }
                }
            }
        }

        // If dp[target] is still "#", it means target is unreachable
        if (dp[target] == "#") {
            return "0";
        } else {
            return dp[target];
        }
    }
};