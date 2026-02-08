class Solution {
public:
    int minimizeArrayValue(vector<int>& nums) {
        int left = 0, right = *max_element(nums.begin(), nums.end());
        while (left < right) {
            int mid = left + (right - left) / 2;
            long long sum = 0, count = 0;
            bool possible = true;
            for (int num : nums) {
                sum += min(num, mid);
                count += (num > mid) ? (num - mid) : 0;
                if (count > sum) {
                    possible = false;
                    break;
                }
            }
            if (possible) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
};