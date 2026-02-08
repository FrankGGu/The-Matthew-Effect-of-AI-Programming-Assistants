class Solution {
public:
    int partitionDisjoint(vector<int>& nums) {
        int n = nums.size();
        vector<int> leftMax(n);
        vector<int> rightMin(n);

        leftMax[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            leftMax[i] = max(leftMax[i-1], nums[i]);
        }

        rightMin[n-1] = nums[n-1];
        for (int i = n-2; i >= 0; --i) {
            rightMin[i] = min(rightMin[i+1], nums[i]);
        }

        for (int i = 0; i < n-1; ++i) {
            if (leftMax[i] <= rightMin[i+1]) {
                return i + 1;
            }
        }

        return -1;
    }
};