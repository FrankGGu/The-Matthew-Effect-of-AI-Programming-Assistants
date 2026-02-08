class SegmentTree {
private:
    vector<int> tree;
    vector<bool> lazy;
    int n;

    void build(const vector<int>& nums, int node, int start, int end) {
        if (start == end) {
            tree[node] = nums[start];
            return;
        }
        int mid = (start + end) / 2;
        build(nums, 2 * node + 1, start, mid);
        build(nums, 2 * node + 2, mid + 1, end);
        tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
    }

    void pushDown(int node, int start, int end) {
        if (lazy[node]) {
            int mid = (start + end) / 2;
            tree[2 * node + 1] = (mid - start + 1) - tree[2 * node + 1];
            tree[2 * node + 2] = (end - mid) - tree[2 * node + 2];
            lazy[2 * node + 1] = !lazy[2 * node + 1];
            lazy[2 * node + 2] = !lazy[2 * node + 2];
            lazy[node] = false;
        }
    }

    void updateRange(int node, int start, int end, int l, int r) {
        if (start > r || end < l) return;
        if (l <= start && end <= r) {
            tree[node] = (end - start + 1) - tree[node];
            lazy[node] = !lazy[node];
            return;
        }
        pushDown(node, start, end);
        int mid = (start + end) / 2;
        updateRange(2 * node + 1, start, mid, l, r);
        updateRange(2 * node + 2, mid + 1, end, l, r);
        tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
    }

    int querySum(int node, int start, int end, int l, int r) {
        if (start > r || end < l) return 0;
        if (l <= start && end <= r) return tree[node];
        pushDown(node, start, end);
        int mid = (start + end) / 2;
        return querySum(2 * node + 1, start, mid, l, r) + querySum(2 * node + 2, mid + 1, end, l, r);
    }

public:
    SegmentTree(const vector<int>& nums) {
        n = nums.size();
        tree.resize(4 * n);
        lazy.resize(4 * n, false);
        build(nums, 0, 0, n - 1);
    }

    void update(int l, int r) {
        updateRange(0, 0, n - 1, l, r);
    }

    int query(int l, int r) {
        return querySum(0, 0, n - 1, l, r);
    }
};

class Solution {
public:
    vector<long long> handleQuery(vector<int>& nums1, vector<int>& nums2, vector<vector<int>>& queries) {
        SegmentTree st(nums1);
        long long sum = accumulate(nums2.begin(), nums2.end(), 0LL);
        vector<long long> res;
        for (const auto& q : queries) {
            if (q[0] == 1) {
                st.update(q[1], q[2]);
            } else if (q[0] == 2) {
                sum += (long long)st.query(0, nums1.size() - 1) * q[1];
            } else {
                res.push_back(sum);
            }
        }
        return res;
    }
};