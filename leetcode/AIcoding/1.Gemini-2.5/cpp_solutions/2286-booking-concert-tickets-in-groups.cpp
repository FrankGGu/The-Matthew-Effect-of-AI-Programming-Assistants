#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class BookMyShow {
public:
    long long n, m;
    vector<long long> sum_tree;
    vector<long long> max_tree;
    vector<long long> sold;
    int first_available_row;

    void build(int node, int start, int end) {
        if (start == end) {
            sum_tree[node] = m;
            max_tree[node] = m;
            return;
        }
        int mid = start + (end - start) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        sum_tree[node] = sum_tree[2 * node] + sum_tree[2 * node + 1];
        max_tree[node] = max(max_tree[2 * node], max_tree[2 * node + 1]);
    }

    void update(int node, int start, int end, int idx, long long val) {
        if (start == end) {
            sum_tree[node] -= val;
            max_tree[node] -= val;
            return;
        }
        int mid = start + (end - start) / 2;
        if (start <= idx && idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        sum_tree[node] = sum_tree[2 * node] + sum_tree[2 * node + 1];
        max_tree[node] = max(max_tree[2 * node], max_tree[2 * node + 1]);
    }

    long long query_sum(int node, int start, int end, int l, int r) {
        if (l > r || r < start || end < l) {
            return 0;
        }
        if (l <= start && end <= r) {
            return sum_tree[node];
        }
        int mid = start + (end - start) / 2;
        long long p1 = query_sum(2 * node, start, mid, l, r);
        long long p2 = query_sum(2 * node + 1, mid + 1, end, l, r);
        return p1 + p2;
    }

    int query_gather(int node, int start, int end, int l, int r, long long k) {
        if (l > r || r < start || end < l || max_tree[node] < k) {
            return -1;
        }
        if (start == end) {
            return start;
        }
        int mid = start + (end - start) / 2;
        int res = query_gather(2 * node, start, mid, l, r, k);
        if (res != -1) {
            return res;
        }
        return query_gather(2 * node + 1, mid + 1, end, l, r, k);
    }

    BookMyShow(int n_rows, int m_seats) {
        n = n_rows;
        m = m_seats;
        sum_tree.resize(4 * n);
        max_tree.resize(4 * n);
        sold.assign(n, 0);
        first_available_row = 0;
        build(1, 0, n - 1);
    }

    vector<int> gather(int k, int maxRow) {
        int row = query_gather(1, 0, n - 1, 0, maxRow, k);
        if (row == -1) {
            return {};
        }

        long long start_seat = sold[row];
        sold[row] += k;
        update(1, 0, n - 1, row, k);

        return {row, (int)start_seat};
    }

    bool scatter(int k, int maxRow) {
        if ((long long)k > query_sum(1, 0, n - 1, first_available_row, maxRow)) {
            return false;
        }

        long long remaining_k = k;
        for (int i = first_available_row; i <= maxRow && remaining_k > 0; ++i) {
            long long available_in_row = m - sold[i];
            long long take = min(remaining_k, available_in_row);
            if (take > 0) {
                sold[i] += take;
                update(1, 0, n - 1, i, take);
                remaining_k -= take;
            }
        }

        while (first_available_row < n && sold[first_available_row] == m) {
            first_available_row++;
        }

        return true;
    }
};