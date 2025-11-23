class Solution {
public:
    int maximumDifference(vector<int>& nums) {
        int maxDiff = -1;
        unordered_map<int, int> freq;

        for (int num : nums) {
            freq[num]++;
        }

        for (auto& [key, value] : freq) {
            if (value % 2 == 0) {
                for (auto& [otherKey, otherValue] : freq) {
                    if (otherValue % 2 != 0) {
                        maxDiff = max(maxDiff, abs(key - otherKey));
                    }
                }
            }
        }
        return maxDiff;
    }
};