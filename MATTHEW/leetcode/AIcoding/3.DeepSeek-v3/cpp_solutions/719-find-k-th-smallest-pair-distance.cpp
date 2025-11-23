class Solution {
public:
    int smallestDistancePair(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int left = 0;
        int right = nums.back() - nums[0];

        while (left < right) {
            int mid = left + (right - left) / 2;
            int count = 0;
            int j = 0;
            for (int i = 0; i < n; ++i) {
                while (j < n && nums[j] - nums[i] <= mid) ++j;
                count += j - i - 1;
            }
            if (count < k) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};