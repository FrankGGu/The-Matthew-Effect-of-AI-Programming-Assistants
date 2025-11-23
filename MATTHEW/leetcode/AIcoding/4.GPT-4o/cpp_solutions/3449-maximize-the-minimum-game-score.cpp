class Solution {
public:
    int maximizeMinimum(int n, vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int left = 0, right = nums[n - 1];
        while (left < right) {
            int mid = left + (right - left + 1) / 2;
            if (canAchieve(nums, mid, n)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }

private:
    bool canAchieve(vector<int>& nums, int minVal, int n) {
        int count = 0;
        for (int num : nums) {
            if (num >= minVal) {
                count++;
            }
            if (count == n) return true;
        }
        return false;
    }
};