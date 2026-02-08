#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestSquareStreak(vector<int>& nums) {
        unordered_set<long long> numSet(nums.begin(), nums.end());
        sort(nums.begin(), nums.end());
        int maxStreak = 0;

        for (int num : nums) {
            long long current = num;
            int streak = 1;

            while (numSet.count(current * current)) {
                current *= current;
                streak++;
            }

            if (streak >= 2) {
                maxStreak = max(maxStreak, streak);
            }
        }

        return maxStreak >= 2 ? maxStreak : -1;
    }
};