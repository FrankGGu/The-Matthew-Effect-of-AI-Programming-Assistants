class Solution {
    public long goodTriplets(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[] pos = new int[n];
        for (int i = 0; i < n; i++) {
            pos[nums2[i]] = i;
        }
        int[] a = new int[n];
        for (int i = 0; i < n; i++) {
            a[i] = pos[nums1[i]];
        }
        int[] left = new int[n];
        int[] right = new int[n];
        FenwickTree ft = new FenwickTree(n);
        for (int i = 0; i < n; i++) {
            left[i] = ft.query(a[i]);
            ft.update(a[i] + 1, 1);
        }
        ft = new FenwickTree(n);
        for (int i = n - 1; i >= 0; i--) {
            right[i] = ft.query(n) - ft.query(a[i] + 1);
            ft.update(a[i] + 1, 1);
        }
        long res = 0;
        for (int i = 0; i < n; i++) {
            res += (long) left[i] * right[i];
        }
        return res;
    }
}

class FenwickTree {
    int[] tree;
    int n;

    public FenwickTree(int n) {
        this.n = n;
        tree = new int[n + 1];
    }

    public void update(int idx, int delta) {
        while (idx <= n) {
            tree[idx] += delta;
            idx += idx & -idx;
        }
    }

    public int query(int idx) {
        int res = 0;
        while (idx > 0) {
            res += tree[idx];
            idx -= idx & -idx;
        }
        return res;
    }
}