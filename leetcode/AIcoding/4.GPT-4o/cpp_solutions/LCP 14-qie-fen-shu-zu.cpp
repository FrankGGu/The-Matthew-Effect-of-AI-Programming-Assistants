class Solution {
public:
    int splitArray(vector<int>& nums, int m) {
        long long left = *max_element(nums.begin(), nums.end()), right = accumulate(nums.begin(), nums.end(), 0LL);
        while (left < right) {
            long long mid = left + (right - left) / 2, sum = 0, count = 1;
            for (int num : nums) {
                if (sum + num > mid) {
                    sum = num;
                    count++;
                } else {
                    sum += num;
                }
            }
            if (count > m) left = mid + 1;
            else right = mid;
        }
        return left;
    }
};