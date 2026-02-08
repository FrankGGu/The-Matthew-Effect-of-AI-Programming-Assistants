#include <vector>

class NumArray {
private:
    std::vector<int> tree;
    int n;

    void build(const std::vector<int>& nums, int node, int start, int end) {
        if (start == end) {
            tree[node] = nums[start];
        } else {
            int mid = start + (end - start) / 2;
            build(nums, 2 * node + 1, start, mid);
            build(nums, 2 * node + 2, mid + 1, end);
            tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
        }
    }

    void update_tree(int node, int start, int end, int idx, int val) {
        if (start == end) {
            tree[node] = val;
        } else {
            int mid = start + (end - start) / 2;
            if (start <= idx && idx <= mid) {
                update_tree(2 * node + 1, start, mid, idx, val);
            } else {
                update_tree(2 * node + 2, mid + 1, end, idx, val);
            }
            tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
        }
    }

    int query_tree(int node, int start, int end, int l, int r) {
        if (r < start || end < l) {
            return 0;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        int mid = start + (end - start) / 2;
        int p1 = query_tree(2 * node + 1, start, mid, l, r);
        int p2 = query_tree(2 * node + 2, mid + 1, end, l, r);
        return p1 + p2;
    }

public:
    NumArray(std::vector<int>& nums) {
        n = nums.size();
        if (n > 0) {
            tree.resize(4 * n);
            build(nums, 0, 0, n - 1);
        }
    }

    void update(int index, int val) {
        if (n == 0) return;
        update_tree(0, 0, n - 1, index, val);
    }

    int sumRange(int left, int right) {
        if (n == 0) return 0;
        return query_tree(0, 0, n - 1, left, right);
    }
};