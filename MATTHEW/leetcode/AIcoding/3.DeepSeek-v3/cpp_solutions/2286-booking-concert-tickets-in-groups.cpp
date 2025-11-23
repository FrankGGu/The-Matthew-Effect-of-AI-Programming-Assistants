class BookMyShow {
public:
    int n, m;
    vector<int> max_seg;
    vector<long long> sum_seg;

    BookMyShow(int _n, int _m) {
        n = _n;
        m = _m;
        max_seg.resize(4 * n);
        sum_seg.resize(4 * n);
        build(0, 0, n - 1);
    }

    void build(int idx, int l, int r) {
        if (l == r) {
            max_seg[idx] = m;
            sum_seg[idx] = m;
            return;
        }
        int mid = (l + r) / 2;
        build(2 * idx + 1, l, mid);
        build(2 * idx + 2, mid + 1, r);
        max_seg[idx] = max(max_seg[2 * idx + 1], max_seg[2 * idx + 2]);
        sum_seg[idx] = sum_seg[2 * idx + 1] + sum_seg[2 * idx + 2];
    }

    void update_max(int idx, int l, int r, int pos, int val) {
        if (l == r) {
            max_seg[idx] = val;
            sum_seg[idx] = val;
            return;
        }
        int mid = (l + r) / 2;
        if (pos <= mid) {
            update_max(2 * idx + 1, l, mid, pos, val);
        } else {
            update_max(2 * idx + 2, mid + 1, r, pos, val);
        }
        max_seg[idx] = max(max_seg[2 * idx + 1], max_seg[2 * idx + 2]);
        sum_seg[idx] = sum_seg[2 * idx + 1] + sum_seg[2 * idx + 2];
    }

    void update_sum(int idx, int l, int r, int pos, int val) {
        if (l == r) {
            sum_seg[idx] = val;
            max_seg[idx] = val;
            return;
        }
        int mid = (l + r) / 2;
        if (pos <= mid) {
            update_sum(2 * idx + 1, l, mid, pos, val);
        } else {
            update_sum(2 * idx + 2, mid + 1, r, pos, val);
        }
        max_seg[idx] = max(max_seg[2 * idx + 1], max_seg[2 * idx + 2]);
        sum_seg[idx] = sum_seg[2 * idx + 1] + sum_seg[2 * idx + 2];
    }

    int query_max(int idx, int l, int r, int L, int R) {
        if (R < l || L > r) return 0;
        if (L <= l && r <= R) return max_seg[idx];
        int mid = (l + r) / 2;
        return max(query_max(2 * idx + 1, l, mid, L, R), query_max(2 * idx + 2, mid + 1, r, L, R));
    }

    long long query_sum(int idx, int l, int r, int L, int R) {
        if (R < l || L > r) return 0;
        if (L <= l && r <= R) return sum_seg[idx];
        int mid = (l + r) / 2;
        return query_sum(2 * idx + 1, l, mid, L, R) + query_sum(2 * idx + 2, mid + 1, r, L, R);
    }

    vector<int> gather(int k, int maxRow) {
        int low = 0, high = maxRow;
        int row = -1;
        while (low <= high) {
            int mid = (low + high) / 2;
            if (query_max(0, 0, n - 1, 0, mid) >= k) {
                row = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        if (row == -1) return {};
        int seats = query_max(0, 0, n - 1, row, row);
        update_max(0, 0, n - 1, row, seats - k);
        return {row, m - seats};
    }

    bool scatter(int k, int maxRow) {
        long long total = query_sum(0, 0, n - 1, 0, maxRow);
        if (total < k) return false;
        int row = 0;
        while (row <= maxRow && k > 0) {
            int seats = query_max(0, 0, n - 1, row, row);
            int take = min(seats, k);
            update_sum(0, 0, n - 1, row, seats - take);
            k -= take;
            row++;
        }
        return true;
    }
};