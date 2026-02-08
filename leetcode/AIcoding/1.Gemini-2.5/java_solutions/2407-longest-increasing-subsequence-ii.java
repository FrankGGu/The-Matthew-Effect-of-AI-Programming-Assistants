class Solution {
    private int[] tree;
    private int MAX_VAL_RANGE;

    private void update(int node, int start, int end, int idx, int val) {
        if (start == end) {
            tree[node] = Math.max(tree[node], val);
        } else {
            int mid = start + (end - start) / 2;
            if (idx <= mid) {
                update(2 * node, start, mid, idx, val);
            } else {
                update(2 * node + 1, mid + 1, end, idx, val);
            }
            tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
        }
    }

    private int query(int node, int start, int end, int l, int r) {
        if (r < start || end < l || l > r) {
            return 0;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        int mid = start + (end - start) / 2;
        int p1 = query(2 * node, start, mid, l, r);
        int p2 = query(2 * node + 1, mid + 1, end, l, r);
        return Math.max(p1, p2);
    }

    public int longestIncreasingSubsequence(int[] nums, int k) {
        MAX_VAL_RANGE = 100000;
        tree = new int[4 * (MAX_VAL_RANGE + 1)];

        int maxLen = 0;

        for (int num : nums) {
            int lowerBound = Math.max(1, num - k);
            int prevMaxLen = query(1, 1, MAX_VAL_RANGE, lowerBound, num - 1);

            int currentLen = 1 + prevMaxLen;
            update(1, 1, MAX_VAL_RANGE, num, currentLen);
            maxLen = Math.max(maxLen, currentLen);
        }

        return maxLen;
    }
}