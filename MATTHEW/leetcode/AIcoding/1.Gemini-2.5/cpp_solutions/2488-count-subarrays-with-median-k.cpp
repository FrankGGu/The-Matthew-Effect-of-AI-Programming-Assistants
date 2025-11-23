#include <vector>

class Solution {
public:
    int countSubarrays(std::vector<int>& nums, int k) {
        return solve(nums, k) - solve(nums, k - 1);
    }

private:
    long long solve(const std::vector<int>& nums, int val) {
        int n = nums.size();
        std::vector<int> p(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            p[i + 1] = p[i] + (nums[i] > val ? 1 : -1);
        }

        std::vector<int> bit(2 * n + 2, 0);

        auto update = [&](int idx, int delta) {
            for (++idx; idx < bit.size(); idx += idx & -idx) {
                bit[idx] += delta;
            }
        };

        auto query = [&](int idx) {
            int sum = 0;
            for (++idx; idx > 0; idx -= idx & -idx) {
                sum += bit[idx];
            }
            return sum;
        };

        long long count = 0;
        for (int i = 0; i <= n; ++i) {
            int shifted_val = p[i] + n;
            count += (long long)i - query(shifted_val - 1);
            update(shifted_val, 1);
        }
        return count;
    }
};