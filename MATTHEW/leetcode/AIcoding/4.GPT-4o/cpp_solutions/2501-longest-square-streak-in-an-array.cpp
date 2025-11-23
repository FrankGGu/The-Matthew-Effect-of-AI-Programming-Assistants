class Solution {
public:
    int longestSquareStreak(vector<int>& nums) {
        unordered_set<int> numSet(nums.begin(), nums.end());
        int longestStreak = 0;

        for (int num : nums) {
            if (numSet.find(num) != numSet.end()) {
                int streak = 0;
                int current = num;

                while (numSet.find(current) != numSet.end()) {
                    streak++;
                    numSet.erase(current);
                    current = current * current;
                }

                longestStreak = max(longestStreak, streak);
            }
        }

        return longestStreak > 1 ? longestStreak : -1;
    }
};