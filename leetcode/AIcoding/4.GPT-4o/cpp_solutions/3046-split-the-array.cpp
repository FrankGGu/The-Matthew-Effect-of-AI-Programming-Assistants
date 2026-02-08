class Solution {
public:
    int splitArray(vector<int>& nums, int m) {
        int left = *max_element(nums.begin(), nums.end());
        int right = accumulate(nums.begin(), nums.end(), 0);

        while (left < right) {
            int mid = left + (right - left) / 2;
            int count = 1, sum = 0;
            for (int num : nums) {
                sum += num;
                if (sum > mid) {
                    count++;
                    sum = num;
                }
            }
            if (count > m) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};