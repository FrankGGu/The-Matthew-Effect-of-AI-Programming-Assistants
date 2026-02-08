#include <vector>
#include <numeric>
#include <algorithm>
#include <set>
#include <unordered_map>
#include <climits>

class Solution {
private:
    std::vector<long long> tree;
    int m;

    void update(int node, int start, int end, int idx, long long val) {
        if (start == end) {
            tree[node] = std::min(tree[node], val);
            return;
        }
        int mid = start + (end - start) / 2;
        if (idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        tree[node] = std::min(tree[2 * node], tree[2 * node + 1]);
    }

    long long query(int node, int start, int end, int l, int r) {
        if (r < start || end < l || l > r) {
            return LLONG_MAX / 2;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        int mid = start + (end - start) / 2;
        long long p1 = query(2 * node, start, mid, l, r);
        long long p2 = query(2 * node + 1, mid + 1, end, l, r);
        return std::min(p1, p2);
    }

public:
    long long maximumGoodSubarraySum(std::vector<int>& nums, int k) {
        int n = nums.size();
        std::vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        std::set<long long> coords_set;
        for (int x : nums) {
            coords_set.insert(x);
            coords_set.insert((long long)x - k);
            coords_set.insert((long long)x + k);
        }

        std::vector<long long> coords(coords_set.begin(), coords_set.end());
        std::unordered_map<long long, int> val_to_idx;
        for (int i = 0; i < coords.size(); ++i) {
            val_to_idx[coords[i]] = i;
        }

        m = coords.size();
        tree.assign(4 * m, LLONG_MAX / 2);

        long long max_sum = LLONG_MIN;

        for (int j = 0; j < n; ++j) {
            int current_val_idx = val_to_idx[nums[j]];
            update(1, 0, m - 1, current_val_idx, prefix[j]);

            long long low_val = (long long)nums[j] - k;
            long long high_val = (long long)nums[j] + k;

            int low_idx = val_to_idx[low_val];
            int high_idx = val_to_idx[high_val];

            long long min_prefix = query(1, 0, m - 1, low_idx, high_idx);

            if (min_prefix < LLONG_MAX / 2) {
                max_sum = std::max(max_sum, prefix[j + 1] - min_prefix);
            }
        }

        return max_sum;
    }
};