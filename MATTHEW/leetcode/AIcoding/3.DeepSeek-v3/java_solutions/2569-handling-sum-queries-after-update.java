class Solution {
    private int[] tree;
    private boolean[] lazy;
    private int n;

    public long[] handleQuery(int[] nums1, int[] nums2, int[][] queries) {
        List<Long> res = new ArrayList<>();
        n = nums1.length;
        tree = new int[4 * n];
        lazy = new boolean[4 * n];
        buildTree(nums1, 0, 0, n - 1);
        long sum = 0;
        for (int num : nums2) {
            sum += num;
        }
        for (int[] query : queries) {
            if (query[0] == 1) {
                int l = query[1];
                int r = query[2];
                updateRange(0, 0, n - 1, l, r);
            } else if (query[0] == 2) {
                int p = query[1];
                sum += (long) tree[0] * p;
            } else if (query[0] == 3) {
                res.add(sum);
            }
        }
        long[] ans = new long[res.size()];
        for (int i = 0; i < res.size(); i++) {
            ans[i] = res.get(i);
        }
        return ans;
    }

    private void buildTree(int[] nums, int node, int start, int end) {
        if (start == end) {
            tree[node] = nums[start];
            return;
        }
        int mid = (start + end) / 2;
        buildTree(nums, 2 * node + 1, start, mid);
        buildTree(nums, 2 * node + 2, mid + 1, end);
        tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
    }

    private void updateRange(int node, int start, int end, int l, int r) {
        if (lazy[node]) {
            tree[node] = (end - start + 1) - tree[node];
            if (start != end) {
                lazy[2 * node + 1] = !lazy[2 * node + 1];
                lazy[2 * node + 2] = !lazy[2 * node + 2];
            }
            lazy[node] = false;
        }
        if (start > end || start > r || end < l) {
            return;
        }
        if (start >= l && end <= r) {
            tree[node] = (end - start + 1) - tree[node];
            if (start != end) {
                lazy[2 * node + 1] = !lazy[2 * node + 1];
                lazy[2 * node + 2] = !lazy[2 * node + 2];
            }
            return;
        }
        int mid = (start + end) / 2;
        updateRange(2 * node + 1, start, mid, l, r);
        updateRange(2 * node + 2, mid + 1, end, l, r);
        tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
    }
}