class Solution {
public:
    double minimizeArrayValue(vector<int>& nums) {
        long long total = 0;
        int n = nums.size();
        for (int num : nums) total += num;

        double left = 0, right = total / n;

        while (left < right) {
            double mid = left + (right - left) / 2;
            double sum = 0;
            for (int num : nums) {
                sum += min(num, mid);
            }
            if (sum < mid * n) {
                right = mid;
            } else {
                left = mid + 1e-7;
            }
        }

        return left;
    }
};