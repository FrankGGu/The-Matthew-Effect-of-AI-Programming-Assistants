class Solution {
public:
    int maxOperations(vector<int>& nums) {
        int count = 0, n = nums.size();
        for (int i = 0; i < n; ++i) {
            if (nums[i] == 1) {
                count++;
            }
        }
        return count;
    }
};