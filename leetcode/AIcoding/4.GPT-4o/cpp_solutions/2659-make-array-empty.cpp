class Solution {
public:
    int countOperationsToEmptyArray(vector<int>& nums) {
        int n = nums.size();
        vector<int> pos(n);
        for (int i = 0; i < n; ++i) {
            pos[nums[i] - 1] = i;
        }
        int operations = 0, maxPos = -1;
        for (int i = 0; i < n; ++i) {
            if (pos[i] > maxPos) {
                maxPos = pos[i];
            } else {
                operations++;
            }
        }
        return operations + n;
    }
};