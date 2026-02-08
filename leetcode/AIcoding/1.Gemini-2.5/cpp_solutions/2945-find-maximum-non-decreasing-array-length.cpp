#include <vector>
#include <algorithm>
#include <map>
#include <tuple>

class SegmentTree {
private:
    int n;
    std::vector<int> tree;

    void update_val(int node, int start, int end, int idx, int val) {
        if (start == end) {
            tree[node] = std::max(tree[node], val);
            return;
        }
        int mid = start + (end - start) / 2;
        if (start <= idx && idx <= mid) {
            update_val(2 * node, start, mid, idx, val);
        } else {
            update_val(2 * node + 1, mid + 1, end, idx, val);
        }
        tree[node] = std::max(tree[2 * node], tree[2 * node + 1]);
    }

    int query_val(int node, int start, int end, int l, int r) {
        if (r < start || end < l) {
            return 0;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        int mid = start + (end - start) / 2;
        int p1 = query_val(2 * node, start, mid, l, r);
        int p2 = query_val(2 * node + 1, mid + 1, end, l, r);
        return std::max(p1, p2);
    }

public:
    SegmentTree(int size) : n(size), tree(4 * size, 0) {}

    void update(int idx, int val) {
        update_val(1, 0, n - 1, idx, val);
    }

    int query(int l, int r) {
        if (l > r) return 0; // Invalid range
        return query_val(1, 0, n - 1, l, r);
    }
};

struct Item {
    int p_val; // Corresponds to nums[i]
    int q_val; // Corresponds to nums[i] - i
    int original_idx; // Original index in nums
};

bool compareItems(const Item& a, const Item& b) {
    if (a.p_val != b.p_val) {
        return a.p_val < b.p_val;
    }
    return a.q_val < b.q_val;
}

class Solution {
public:
    int findMaximumNonDecreasingArrayLength(std::vector<int>& nums) {
        int n = nums.size();

        std::vector<Item> items;
        std::vector<int> q_coords; // For coordinate compression of q_val (nums[i]-i)

        for (int i = 0; i < n; ++i) {
            items.push_back({nums[i], nums[i] - i, i});
            q_coords.push_back(nums[i] - i);
        }

        // Coordinate compress q_coords
        std::sort(q_coords.begin(), q_coords.end());
        q_coords.erase(std::unique(q_coords.begin(), q_coords.end()), q_coords.end());

        // Create a map for compressed q_val indices
        std::map<int, int> q_map;
        for (int i = 0; i < q_coords.size(); ++i) {
            q_map[q_coords[i]] = i;
        }

        // Sort items using the custom comparator
        std::sort(items.begin(), items.end(), compareItems);

        SegmentTree st(q_coords.size());
        int max_overall_len = 0;

        // Iterate through sorted items, processing groups with the same p_val
        int i = 0;
        while (i < n) {
            int current_p_val = items[i].p_val;
            std::vector<std::pair<int, int>> updates_for_current_p; // Stores {compressed_q_val, length}

            int j = i;
            while (j < n && items[j].p_val == current_p_val) {
                int q_compressed_idx = q_map[items[j].q_val];

                // Query the segment tree for max length ending with q_val <= current_q_val
                // The query range is [0, q_compressed_idx].
                // This query correctly considers items with p_val < current_p_val
                // and for items with p_val == current_p_val, it does not consider them
                // because updates are deferred. This handles the original_idx constraint.
                int max_len_prev = st.query(0, q_compressed_idx);

                int current_len = max_len_prev + 1;
                max_overall_len = std::max(max_overall_len, current_len);

                // Store updates to be applied after all queries for current_p_val are done
                updates_for_current_p.push_back({q_compressed_idx, current_len});
                j++;
            }

            // Apply all updates for the current_p_val group to the segment tree.
            // This ensures that queries for items with current_p_val only consider items with p_val < current_p_val.
            for (const auto& upd : updates_for_current_p) {
                st.update(upd.first, upd.second);
            }

            i = j; // Move to the next group
        }

        return max_overall_len;
    }
};