class Solution {
public:
    int specialArray(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        for (int x = 0; x <= n; ++x) {
            int left = 0, right = n;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (nums[mid] >= x) {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }
            if (n - left == x) {
                return x;
            }
        }
        return -1;
    }
};