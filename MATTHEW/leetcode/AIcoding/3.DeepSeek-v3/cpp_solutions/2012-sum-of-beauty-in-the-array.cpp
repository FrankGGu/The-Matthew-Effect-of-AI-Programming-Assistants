class Solution {
public:
    int sumOfBeauties(vector<int>& nums) {
        int n = nums.size();
        vector<int> leftMax(n, 0);
        vector<int> rightMin(n, INT_MAX);

        leftMax[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            leftMax[i] = max(leftMax[i-1], nums[i]);
        }

        rightMin[n-1] = nums[n-1];
        for (int i = n-2; i >= 0; --i) {
            rightMin[i] = min(rightMin[i+1], nums[i]);
        }

        int sum = 0;
        for (int i = 1; i < n-1; ++i) {
            if (leftMax[i-1] < nums[i] && nums[i] < rightMin[i+1]) {
                sum += 2;
            } else if (nums[i-1] < nums[i] && nums[i] < nums[i+1]) {
                sum += 1;
            }
        }

        return sum;
    }
};