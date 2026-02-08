#include <vector>
#include <algorithm>
#include <tuple>

class SegmentTree {
public:
    std::vector<int> tree;
    int size;

    SegmentTree(int n) : size(n) {
        tree.assign(4 * n, -1);
    }

    void update(int node, int start, int end, int idx, int val) {
        if (start == end) {
            tree[node] = std::max(tree[node], val);
        } else {
            int mid = (start + end) / 2;
            if (start <= idx && idx <= mid) {
                update(2 * node, start, mid, idx, val);
            } else {
                update(2 * node + 1, mid + 1, end, idx, val);
            }
            tree[node] = std::max(tree[2 * node], tree[2 * node + 1]);
        }
    }

    int query(int node, int start, int end, int l, int r) {
        if (r < start || end < l) {
            return -1;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        int mid = (start + end) / 2;
        int p1 = query(2 * node, start, mid, l, r);
        int p2 = query(2 * node + 1, mid + 1, end, l, r);
        return std::max(p1, p2);
    }
};

class Solution {
public:
    std::vector<int> maximumSumQueries(std::vector<int>& nums1, std::vector<int>& nums2, std::vector<std::vector<int>>& queries) {
        int n = nums1.size();
        int m = queries.size();

        std::vector<std::pair<int, int>> points(n);
        for (int i = 0; i < n; ++i) {
            points[i] = {nums1[i], nums2[i]};
        }

        std::vector<std::tuple<int, int, int>> queries_with_idx(m);
        for (int i = 0; i < m; ++i) {
            queries_with_idx[i] = {queries[i][0], queries[i][1], i};
        }

        std::vector<int> all_y_values;
        all_y_values.reserve(n + m);
        for (const auto& p : points) {
            all_y_values.push_back(p.second);
        }
        for (const auto& q : queries_with_idx) {
            all_y_values.push_back(std::get<1>(q));
        }

        std::sort(all_y_values.begin(), all_y_values.end());
        all_y_values.erase(std::unique(all_y_values.begin(), all_y_values.end()), all_y_values.end());

        std::sort(points.begin(), points.end(), [](const auto& a, const auto& b) {
            return a.first > b.first;
        });

        std::sort(queries_with_idx.begin(), queries_with_idx.end(), [](const auto& a, const auto& b) {
            return std::get<0>(a) > std::get<0>(b);
        });

        std::vector<int> ans(m);
        SegmentTree st(all_y_values.size());

        int point_ptr = 0;
        for (const auto& q_tuple : queries_with_idx) {
            int x_q = std::get<0>(q_tuple);
            int y_q = std::get<1>(q_tuple);
            int original_idx = std::get<2>(q_tuple);

            while (point_ptr < n && points[point_ptr].first >= x_q) {
                int p_nums1 = points[point_ptr].first;
                int p_nums2 = points[point_ptr].second;

                auto it = std::lower_bound(all_y_values.begin(), all_y_values.end(), p_nums2);
                int y_idx = std::distance(all_y_values.begin(), it);

                st.update(1, 0, all_y_values.size() - 1, y_idx, p_nums1 + p_nums2);
                point_ptr++;
            }

            auto it_y_q = std::lower_bound(all_y_values.begin(), all_y_values.end(), y_q);
            int query_y_start_idx = std::distance(all_y_values.begin(), it_y_q);

            if (query_y_start_idx < all_y_values.size()) {
                ans[original_idx] = st.query(1, 0, all_y_values.size() - 1, query_y_start_idx, all_y_values.size() - 1);
            } else {
                ans[original_idx] = -1;
            }
        }

        return ans;
    }
};