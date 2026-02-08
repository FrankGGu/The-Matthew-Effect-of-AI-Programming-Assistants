#include <vector>
#include <unordered_set>

class Solution {
public:
    int maxCount(std::vector<int>& banned, int n, int maxSum) {
        std::unordered_set<int> banned_set(banned.begin(), banned.end());
        int count = 0;
        long long current_sum = 0;

        for (int i = 1; i <= n; ++i) {
            if (banned_set.find(i) == banned_set.end()) {
                if (current_sum + i <= maxSum) {
                    current_sum += i;
                    count++;
                } else {
                    break;
                }
            }
        }

        return count;
    }
};