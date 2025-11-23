class Solution {
public:
    int uniqueMiddleModeI(vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        int uniqueMode = -1;
        int maxCount = 0;

        for (const auto& entry : count) {
            if (entry.second > maxCount) {
                maxCount = entry.second;
                uniqueMode = entry.first;
            } else if (entry.second == maxCount) {
                uniqueMode = -1;
            }
        }

        return uniqueMode;
    }
};