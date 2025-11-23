class Solution {
public:
    int maxValueAfterReverse(vector<int>& nums) {
        int total = 0, res = 0, min2 = 123456, max2 = -123456, n = nums.size();
        for (int i = 0; i < n - 1; i++) {
            int a = nums[i], b = nums[i + 1];
            total += abs(a - b);
            res = max(res, abs(nums[0] - b) - abs(a - b));
            res = max(res, abs(nums[n - 1] - a) - abs(a - b));
            min2 = min(min2, max(a, b));
            max2 = max(max2, min(a, b));
        }
        return total + max(res, 2 * (max2 - min2));
    }
};