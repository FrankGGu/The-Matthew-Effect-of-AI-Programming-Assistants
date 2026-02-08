#include <vector>
#include <algorithm>
#include <climits>

class Solution {
private:
    std::vector<int> tree;
    std::vector<int> dr_nums;
    int n;

    void build(int node, int start, int end) {
        if (start == end) {
            tree[node] = dr_nums[start];
            return;
        }
        int mid = start + (end - start) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node] = std::min(tree[2 * node], tree[2 * node + 1]);
    }

    int query(int node, int start, int end, int l, int r) {
        if (r < start || end < l) {
            return INT_MAX;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        int mid = start + (end - start) / 2;
        int p1 = query(2 * node, start, mid, l, r);
        int p2 = query(2 * node + 1, mid + 1, end, l, r);
        return std::min(p1, p2);
    }

public:
    std::vector<int> minimumElementAfterOperations(std::vector<int>& nums, std::vector<std::vector<int>>& queries) {
        n = nums.size();
        dr_nums.resize(n);
        for (int i = 0; i < n; ++i) {
            dr_nums[i] = (nums[i] - 1) % 9 + 1;
        }

        tree.resize(4 * n);
        if (n > 0) {
            build(1, 0, n - 1);
        }

        std::vector<int> result;
        result.reserve(queries.size());
        for (const auto& q : queries) {
            result.push_back(query(1, 0, n - 1, q[0], q[1]));
        }

        return result;
    }
};