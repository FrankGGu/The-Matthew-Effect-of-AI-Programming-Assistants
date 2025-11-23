class Solution {
public:
    int countNiceSubarrays(vector<int>& nums, int k) {
        int count = 0, left = 0, oddCount = 0;
        for (int right = 0; right < nums.size(); ++right) {
            if (nums[right] % 2 != 0) oddCount++;
            while (oddCount > k) {
                if (nums[left] % 2 != 0) oddCount--;
                left++;
            }
            if (oddCount == k) {
                int tempLeft = left;
                while (tempLeft < nums.size() && nums[tempLeft] % 2 == 0) tempLeft++;
                int tempRight = right;
                while (tempRight >= 0 && nums[tempRight] % 2 == 0) tempRight--;
                count += (tempLeft - left + 1) * (right - tempRight);
            }
        }
        return count;
    }
};