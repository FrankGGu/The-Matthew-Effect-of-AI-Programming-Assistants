class Solution {
public:
    int findMinCost(vector<int>& nums, vector<int>& cost) {
        auto f = [&](long long x) {
            long long total_cost = 0;
            for (int i = 0; i < nums.size(); i++) {
                total_cost += abs(nums[i] - x) * cost[i];
            }
            return total_cost;
        };

        long long left = *min_element(nums.begin(), nums.end());
        long long right = *max_element(nums.begin(), nums.end());

        while (left < right) {
            long long mid = left + (right - left) / 2;
            if (f(mid) <= f(mid + 1)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return f(left);
    }
};