class Solution {
public:
    int maximumLength(vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        int maxLength = 0;
        for (auto& entry : count) {
            if (entry.second > 1) {
                maxLength += 2;
            } else {
                maxLength++;
            }
        }

        return maxLength;
    }
};