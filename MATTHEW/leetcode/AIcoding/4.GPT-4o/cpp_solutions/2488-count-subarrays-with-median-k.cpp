class Solution {
public:
    int countSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        int count = 0;
        int medianPos = -1;

        for (int i = 0; i < n; i++) {
            if (nums[i] == k) {
                medianPos = i;
                break;
            }
        }

        if (medianPos == -1) return 0;

        int leftCount = 0, rightCount = 0;
        for (int i = medianPos - 1; i >= 0; i--) {
            if (nums[i] < k) leftCount++;
            else if (nums[i] > k) break;
        }
        for (int i = medianPos + 1; i < n; i++) {
            if (nums[i] < k) rightCount++;
            else if (nums[i] > k) break;
        }

        count += (leftCount + 1) * (rightCount + 1);
        return count;
    }
};