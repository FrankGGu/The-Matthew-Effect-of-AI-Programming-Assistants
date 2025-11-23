class Solution {
public:
    int maximumCount(vector<int>& nums) {
        int positiveCount = 0, negativeCount = 0;
        for (int num : nums) {
            if (num > 0) positiveCount++;
            else if (num < 0) negativeCount++;
        }
        return max(positiveCount, negativeCount);
    }
};