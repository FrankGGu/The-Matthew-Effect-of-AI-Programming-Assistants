class NumArray {
private:
    vector<int> tree;
    vector<int> nums;
    int n;

    void buildTree(int node, int start, int end) {
        if (start == end) {
            tree[node] = nums[start];
            return;
        }
        int mid = start + (end - start) / 2;
        buildTree(2 * node + 1, start, mid);
        buildTree(2 * node + 2, mid + 1, end);
        tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
    }

    void updateTree(int node, int start, int end, int idx, int val) {
        if (start == end) {
            nums[idx] = val;
            tree[node] = val;
            return;
        }
        int mid = start + (end - start) / 2;
        if (idx <= mid) {
            updateTree(2 * node + 1, start, mid, idx, val);
        } else {
            updateTree(2 * node + 2, mid + 1, end, idx, val);
        }
        tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
    }

    int queryTree(int node, int start, int end, int left, int right) {
        if (right < start || left > end) return 0;
        if (left <= start && end <= right) return tree[node];
        int mid = start + (end - start) / 2;
        return queryTree(2 * node + 1, start, mid, left, right) + queryTree(2 * node + 2, mid + 1, end, left, right);
    }

public:
    NumArray(vector<int>& nums) {
        this->nums = nums;
        n = nums.size();
        tree.resize(4 * n);
        buildTree(0, 0, n - 1);
    }

    void update(int index, int val) {
        updateTree(0, 0, n - 1, index, val);
    }

    int sumRange(int left, int right) {
        return queryTree(0, 0, n - 1, left, right);
    }
};