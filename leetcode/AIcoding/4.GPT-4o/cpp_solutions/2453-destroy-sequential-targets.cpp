class Solution {
public:
    int destroyTargets(vector<int>& nums, int target) {
        int count = 0;
        for (int num : nums) {
            if (num % target == 0) {
                count++;
            }
        }
        return count;
    }
};