class Solution {
public:
    int minimizeMax(vector<int>& nums, int p) {
        sort(nums.begin(), nums.end());
        int low = 0, high = nums.back();
        while (low < high) {
            int mid = low + (high - low) / 2, pairs = 0;
            for (int i = 1; i < nums.size(); i++) {
                if (nums[i] - nums[i - 1] <= mid) {
                    pairs++;
                    i++;
                }
            }
            if (pairs >= p) high = mid;
            else low = mid + 1;
        }
        return low;
    }
};