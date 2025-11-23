#include <vector>
#include <algorithm>
#include <climits>

class Solution {
private:
    std::vector<long long> bit;
    int size;
    const long long NEGINF = LLONG_MIN / 2;

    void update(int idx, long long val) {
        for (; idx <= size; idx += idx & -idx) {
            bit[idx] = std::max(bit[idx], val);
        }
    }

    long long query(int idx) {
        long long res = NEGINF;
        for (; idx > 0; idx -= idx & -idx) {
            res = std::max(res, bit[idx]);
        }
        return res;
    }

public:
    long long maxBalancedSubsequenceSum(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> b(n);
        for (int i = 0; i < n; ++i) {
            b[i] = nums[i] - i;
        }

        std::vector<int> sorted_b = b;
        std::sort(sorted_b.begin(), sorted_b.end());
        sorted_b.erase(std::unique(sorted_b.begin(), sorted_b.end()), sorted_b.end());

        size = sorted_b.size();
        bit.assign(size + 1, NEGINF);

        long long max_sum = NEGINF;

        for (int i = 0; i < n; ++i) {
            int idx = std::lower_bound(sorted_b.begin(), sorted_b.end(), b[i]) - sorted_b.begin() + 1;

            long long max_prev = query(idx);

            long long current_sum = (long long)nums[i];
            if (max_prev > 0) {
                current_sum += max_prev;
            }

            update(idx, current_sum);

            max_sum = std::max(max_sum, current_sum);
        }

        return max_sum;
    }
};