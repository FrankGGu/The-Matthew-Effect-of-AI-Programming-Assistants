#include <vector>
#include <algorithm>

struct Node {
    int val; // maximum length of a good subsequence
    int idx; // index (count_gt_k) where this maximum length is achieved

    Node(int v = 0, int i = -1) : val(v), idx(i) {}
};

Node merge(const Node& left, const Node& right) {
    if (left.val > right.val) {
        return left;
    } else if (right.val > left.val) {
        return right;
    } else { // values are equal
        if (left.val == 0 && left.idx == -1) return right; // Left is an invalid node, return right
        if (right.val == 0 && right.idx == -1) return left; // Right is an invalid node, return left

        // Both nodes are valid and have the same max_val, prefer smaller index
        return (left.idx < right.idx) ? left : right;
    }
}

class SegmentTree {
private:
    std::vector<Node> tree;
    int N_seg; // Size of the base array (k + 1, for indices 0 to k)

    // Builds the segment tree
    void build(int node_idx, int start, int end) {
        if (start == end) {
            tree[node_idx] = Node(0, start); // Initialize with 0 length, at its index
        } else {
            int mid = start + (end - start) / 2;
            build(2 * node_idx, start, mid);
            build(2 * node_idx + 1, mid + 1, end);
            tree[node_idx] = merge(tree[2 * node_idx], tree[2 * node_idx + 1]);
        }
    }

    // Updates a specific index in the segment tree
    void update_tree(int node_idx, int start, int end, int idx, int val) {
        if (start == end) {
            // Update only if the new value is greater
            if (val > tree[node_idx].val) {
                tree[node_idx].val = val;
            }
        } else {
            int mid = start + (end - start) / 2;
            if (start <= idx && idx <= mid) {
                update_tree(2 * node_idx, start, mid, idx, val);
            } else {
                update_tree(2 * node_idx + 1, mid + 1, end, idx, val);
            }
            tree[node_idx] = merge(tree[2 * node_idx], tree[2 * node_idx + 1]);
        }
    }

    // Queries for the maximum value in a given range [l, r]
    Node query_tree(int node_idx, int start, int end, int l, int r) {
        // If the current segment is outside the query range
        if (r < start || end < l) {
            return Node(0, -1); // Return an identity element for max query
        }
        // If the current segment is completely within the query range
        if (l <= start && end <= r) {
            return tree[node_idx];
        }
        // Partially overlapping, recurse
        int mid = start + (end - start) / 2;
        Node p1 = query_tree(2 * node_idx, start, mid, l, r);
        Node p2 = query_tree(2 * node_idx + 1, mid + 1, end, l, r);
        return merge(p1, p2);
    }

public:
    SegmentTree(int size) : N_seg(size) {
        tree.resize(4 * N_seg); // Allocate memory for the tree
        build(1, 0, N_seg - 1); // Build the tree from index 1 (root)
    }

    // Public interface for updating
    void update(int idx, int val) {
        update_tree(1, 0, N_seg - 1, idx, val);
    }

    // Public interface for querying
    Node query(int l, int r) {
        if (l > r) return Node(0, -1); // Invalid range
        return query_tree(1, 0, N_seg - 1, l, r);
    }
};

class Solution {
public:
    int maximumLength(std::vector<int>& nums, int k) {
        int max_k_plus_1 = k + 1; // Array/segment tree size for counts 0 to k

        // Segment trees to store max lengths for subsequences ending with even/odd numbers
        // Indexed by the count of elements greater than k
        SegmentTree seg_even(max_k_plus_1); // For subsequences ending with an even number
        SegmentTree seg_odd(max_k_plus_1);  // For subsequences ending with an odd number

        int overall_max_len = 0;

        for (int x : nums) {
            int p = x % 2; // Parity of current number x (0 for even, 1 for odd)
            int gt = (x > k) ? 1 : 0; // 1 if x > k, 0 otherwise

            SegmentTree* source_seg; // Segment tree for the opposite parity
            SegmentTree* target_seg; // Segment tree for the current parity

            if (p == 0) { // Current number x is even
                source_seg = &seg_odd;
                target_seg = &seg_even;
            } else { // Current number x is odd
                source_seg = &seg_even;
                target_seg = &seg_odd;
            }

            // Case 1: x starts a new subsequence
            int len_if_starts_new = 0;
            if (gt <= k) { // A single element subsequence must respect the k constraint
                len_if_starts_new = 1;
            }

            // Case 2: x extends an existing subsequence
            int prev_max_len_val = 0;
            int prev_max_len_idx = -1; // This will be the count_gt_k of the previous subsequence

            // The previous subsequence must have `c_prev` elements > k such that `c_prev + gt <= k`.
            // So, `c_prev <= k - gt`.
            int query_upper_bound = k - gt;

            if (query_upper_bound >= 0) {
                Node query_res = source_seg->query(0, query_upper_bound);
                prev_max_len_val = query_res.val;
                prev_max_len_idx = query_res.idx;
            }

            int current_max_len = 0;      // Max length for a subsequence ending with x
            int current_gt_k_count = 0;   // Corresponding count_gt_k for current_max_len

            // Compare the two cases (starting new vs. extending)
            // Prioritize starting new if it yields a greater length
            if (len_if_starts_new > current_max_len) {
                current_max_len = len_if_starts_new;
                current_gt_k_count = gt;
            }

            // If a valid previous subsequence was found
            if (prev_max_len_val > 0) {
                int new_len_from_prev = 1 + prev_max_len_val;
                int new_gt_k_count_from_prev = prev_max_len_idx + gt;

                if (new_len_from_prev > current_max_len) {
                    current_max_len = new_len_from_prev;
                    current_gt_k_count = new_gt_k_count_from_prev;
                } else if (new_len_from_prev == current_max_len) {
                    // If lengths are equal, prefer the one with fewer elements > k
                    current_gt_k_count = std::min(current_gt_k_count, new_gt_k_count_from_prev);
                }
            }

            // Update the segment tree for the current parity with the best length found for x
            if (current_max_len > 0) {
                target_seg->update(current_gt_k_count, current_max_len);
                overall_max_len = std::max(overall_max_len, current_max_len);
            }
        }

        return overall_max_len;
    }
};