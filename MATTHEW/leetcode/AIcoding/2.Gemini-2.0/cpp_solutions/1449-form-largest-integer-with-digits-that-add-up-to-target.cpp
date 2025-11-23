#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestNumber(vector<int>& cost, int target) {
        vector<string> dp(target + 1, "0");
        dp[0] = "";

        for (int i = 1; i <= 9; ++i) {
            for (int j = cost[i - 1]; j <= target; ++j) {
                string prev = dp[j - cost[i - 1]];
                if (prev != "0") {
                    string current = prev + to_string(i);
                    if (dp[j] == "0" || current.length() > dp[j].length() || (current.length() == dp[j].length() && current > dp[j])) {
                        dp[j] = current;
                    }
                }
            }
        }

        return dp[target] == "0" ? "0" : dp[target];
    }
};