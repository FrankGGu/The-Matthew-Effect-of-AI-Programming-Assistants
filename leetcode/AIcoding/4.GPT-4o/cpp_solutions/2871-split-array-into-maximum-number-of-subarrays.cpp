class Solution {
public:
    int maximumSubarrays(vector<int>& nums) {
        int count = 0, currentMax = 0;
        for (int num : nums) {
            if (num > currentMax) {
                count++;
                currentMax = num;
            }
        }
        return count;
    }
};