#include <vector>
#include <algorithm>
#include <map>
#include <set>
#include <unordered_map>

class Solution {
private:
    struct SegTree {
        std::vector<int> max_v;
        std::vector<int> lazy;
        int n;

        SegTree(int size) : n(size) {
            max_v.assign(4 * n, 0);
            lazy.assign(4 * n, 0);
        }

        void push_up(int p) {
            max_v[p] = std::max(max_v[p * 2], max_v[p * 2 + 1]);
        }

        void push_down(int p) {
            if (lazy[p] != 0) {
                max_v[p * 2] += lazy[p];
                lazy[p * 2] += lazy[p];
                max_v[p * 2 + 1] += lazy[p];
                lazy[p * 2 + 1] += lazy[p];
                lazy[p] = 0;
            }
        }

        void update(int p, int l, int r, int L, int R, int val) {
            if (L > R) return;
            if (L <= l && r <= R) {
                max_v[p] += val;
                lazy[p] += val;
                return;
            }
            push_down(p);
            int mid = l + (r - l) / 2;
            if (L <= mid) {
                update(p * 2, l, mid, L, R, val);
            }
            if (R > mid) {
                update(p * 2 + 1, mid + 1, r, L, R, val);
            }
            push_up(p);
        }

        void update(int L, int R, int val) {
            update(1, 0, n - 1, L, R, val);
        }

        int query_max() {
            return max_v[1];
        }
    };

public:
    int fieldOfGreatestBlessing(std::vector<std::vector<int>>& forceFields) {
        if (forceFields.empty()) {
            return 0;
        }

        std::vector<long long> y_coords_vec;
        y_coords_vec.reserve(forceFields.size() * 2);
        for (const auto& f : forceFields) {
            long long y = f[1], s = f[2];
            y_coords_vec.push_back(y - s);
            y_coords_vec.push_back(y + s + 1);
        }
        std::sort(y_coords_vec.begin(), y_coords_vec.end());
        y_coords_vec.erase(std::unique(y_coords_vec.begin(), y_coords_vec.end()), y_coords_vec.end());

        int m = y_coords_vec.size();
        std::unordered_map<long long, int> y_map;
        for (int i = 0; i < m; ++i) {
            y_map[y_coords_vec[i]] = i;
        }

        struct Event {
            long long x;
            int y1_idx, y2_idx;
            int type;
        };

        std::vector<Event> events;
        events.reserve(forceFields.size() * 2);
        for (const auto& f : forceFields) {
            long long x = f[0], y = f[1], s = f[2];
            long long x1 = x - s, x2 = x + s;
            long long y1 = y - s, y2 = y + s;
            int y1_idx = y_map[y1];
            int y2_idx = y_map[y2 + 1];
            events.push_back({x1, y1_idx, y2_idx, 1});
            events.push_back({x2 + 1, y1_idx, y2_idx, -1});
        }

        std::sort(events.begin(), events.end(), [](const Event& a, const Event& b) {
            return a.x < b.x;
        });

        if (m == 0) return 0;
        SegTree tree(m);
        int max_blessings = 0;

        for (int i = 0; i < events.size(); ) {
            long long current_x = events[i].x;
            int j = i;
            while (j < events.size() && events[j].x == current_x) {
                const auto& e = events[j];
                tree.update(e.y1_idx, e.y2_idx - 1, e.type);
                j++;
            }
            max_blessings = std::max(max_blessings, tree.query_max());
            i = j;
        }

        return max_blessings;
    }
};