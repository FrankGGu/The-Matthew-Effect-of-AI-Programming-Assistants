#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool backtrack(vector<int>& matchsticks, vector<bool>& used, int index, int currentSum, int target, int k) {
        if (k == 0) return true;
        if (currentSum == target) return backtrack(matchsticks, used, 0, 0, target, k - 1);
        for (int i = index; i < matchsticks.size(); ++i) {
            if (!used[i] && currentSum + matchsticks[i] <= target) {
                used[i] = true;
                if (backtrack(matchsticks, used, i + 1, currentSum + matchsticks[i], target, k)) {
                    return true;
                }
                used[i] = false;
            }
        }
        return false;
    }

    bool canPartitionKSubsets(vector<int>& matchsticks, int k) {
        int total = 0;
        for (int& m : matchsticks) total += m;
        if (total % k != 0) return false;
        int target = total / k;
        sort(matchsticks.begin(), matchsticks.end(), greater<int>());
        vector<bool> used(matchsticks.size(), false);
        return backtrack(matchsticks, used, 0, 0, target, k);
    }

    bool makesquare(vector<int>& matchsticks) {
        return canPartitionKSubsets(matchsticks, 4);
    }
};