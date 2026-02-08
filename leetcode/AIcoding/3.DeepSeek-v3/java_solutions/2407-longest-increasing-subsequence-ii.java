class Solution {
    public int lengthOfLIS(int[] nums, int k) {
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }
        SegmentTree st = new SegmentTree(maxNum);
        int res = 0;
        for (int num : nums) {
            int preMax = st.query(Math.max(1, num - k), num - 1);
            int current = preMax + 1;
            res = Math.max(res, current);
            st.update(num, current);
        }
        return res;
    }
}

class SegmentTree {
    private int[] tree;
    private int size;

    public SegmentTree(int size) {
        this.size = size;
        tree = new int[4 * size];
    }

    public void update(int index, int value) {
        update(1, 1, size, index, value);
    }

    private void update(int node, int start, int end, int index, int value) {
        if (start == end) {
            tree[node] = value;
            return;
        }
        int mid = (start + end) / 2;
        if (index <= mid) {
            update(2 * node, start, mid, index, value);
        } else {
            update(2 * node + 1, mid + 1, end, index, value);
        }
        tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
    }

    public int query(int l, int r) {
        if (l > r) return 0;
        return query(1, 1, size, l, r);
    }

    private int query(int node, int start, int end, int l, int r) {
        if (r < start || end < l) return 0;
        if (l <= start && end <= r) return tree[node];
        int mid = (start + end) / 2;
        int left = query(2 * node, start, mid, l, r);
        int right = query(2 * node + 1, mid + 1, end, l, r);
        return Math.max(left, right);
    }
}