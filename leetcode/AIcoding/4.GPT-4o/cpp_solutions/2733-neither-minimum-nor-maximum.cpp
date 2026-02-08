class Solution {
public:
    int findNonMinOrMax(vector<int>& nums) {
        if (nums.size() <= 2) return -1;
        int minVal = INT_MAX, maxVal = INT_MIN;
        for (int num : nums) {
            minVal = min(minVal, num);
            maxVal = max(maxVal, num);
        }
        for (int num : nums) {
            if (num != minVal && num != maxVal) {
                return num;
            }
        }
        return -1;
    }
};