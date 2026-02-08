class Solution {
public:
    int minimumDifference(vector<int>& nums) {
        int n = nums.size() / 2;
        vector<int> left(nums.begin(), nums.begin() + n);
        vector<int> right(nums.begin() + n, nums.end());

        vector<vector<int>> left_sums(n + 1);
        vector<vector<int>> right_sums(n + 1);

        for (int mask = 0; mask < (1 << n); ++mask) {
            int cnt = __builtin_popcount(mask);
            int sum = 0;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    sum += left[i];
                }
            }
            left_sums[cnt].push_back(sum);
        }

        for (int mask = 0; mask < (1 << n); ++mask) {
            int cnt = __builtin_popcount(mask);
            int sum = 0;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    sum += right[i];
                }
            }
            right_sums[cnt].push_back(sum);
        }

        for (int k = 0; k <= n; ++k) {
            sort(right_sums[k].begin(), right_sums[k].end());
        }

        int total = accumulate(nums.begin(), nums.end(), 0);
        int target = total / 2;
        int res = INT_MAX;

        for (int k = 0; k <= n; ++k) {
            for (int a : left_sums[k]) {
                int rem = n - k;
                auto& vec = right_sums[rem];
                auto it = lower_bound(vec.begin(), vec.end(), target - a);
                if (it != vec.end()) {
                    int sum = a + *it;
                    res = min(res, abs(total - 2 * sum));
                }
                if (it != vec.begin()) {
                    --it;
                    int sum = a + *it;
                    res = min(res, abs(total - 2 * sum));
                }
            }
        }

        return res;
    }
};