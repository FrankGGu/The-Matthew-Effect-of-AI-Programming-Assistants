class BookMyShow {

    private int n;
    private int seatsPerRow;
    private long[] tree;
    private long[] sumTree;

    public BookMyShow(int n, int seatsPerRow) {
        this.n = n;
        this.seatsPerRow = seatsPerRow;
        this.tree = new long[4 * n];
        this.sumTree = new long[4 * n];

        build(1, 1, n);
    }

    private void build(int node, int start, int end) {
        if (start == end) {
            tree[node] = seatsPerRow;
            sumTree[node] = seatsPerRow;
            return;
        }

        int mid = (start + end) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);

        tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
        sumTree[node] = sumTree[2 * node] + sumTree[2 * node + 1];
    }

    public int gather(int k, int maxRow) {
        int row = findRow(1, 1, n, k, maxRow);
        if (row == -1) {
            return -1;
        }

        update(1, 1, n, row, k);
        return row - 1;
    }

    private int findRow(int node, int start, int end, int k, int maxRow) {
        if (start > maxRow + 1) {
            return -1;
        }

        if (tree[node] < k) {
            return -1;
        }

        if (start == end) {
            return start;
        }

        int mid = (start + end) / 2;
        int left = findRow(2 * node, start, mid, k, maxRow);

        if (left != -1) {
            return left;
        } else {
            return findRow(2 * node + 1, mid + 1, end, k, maxRow);
        }
    }

    private void update(int node, int start, int end, int row, int k) {
        if (start == end) {
            tree[node] -= k;
            sumTree[node] -= k;
            return;
        }

        int mid = (start + end) / 2;
        if (row <= mid) {
            update(2 * node, start, mid, row, k);
        } else {
            update(2 * node + 1, mid + 1, end, row, k);
        }

        tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
        sumTree[node] = sumTree[2 * node] + sumTree[2 * node + 1];
    }

    public boolean scatter(int k, int maxRow) {
        if (getSum(1, 1, n, 1, maxRow + 1) < k) {
            return false;
        }

        scatterUpdate(1, 1, n, k, maxRow);
        return true;
    }

    private long getSum(int node, int start, int end, int l, int r) {
        if (l > end || r < start) {
            return 0;
        }

        if (l <= start && end <= r) {
            return sumTree[node];
        }

        int mid = (start + end) / 2;
        return getSum(2 * node, start, mid, l, r) + getSum(2 * node + 1, mid + 1, end, l, r);
    }

    private int scatterUpdate(int node, int start, int end, int k, int maxRow) {
        if (start > maxRow + 1 || k == 0) return 0;

        if (start == end) {
            int booked = Math.min((int)sumTree[node], k);
            sumTree[node] -= booked;
            tree[node] = sumTree[node];
            return booked;
        }

        int mid = (start + end) / 2;
        int booked = scatterUpdate(2 * node, start, mid, k, maxRow);
        k -= booked;
        booked += scatterUpdate(2 * node + 1, mid + 1, end, k, maxRow);

        sumTree[node] = sumTree[2 * node] + sumTree[2 * node + 1];
        tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
        return booked;
    }
}