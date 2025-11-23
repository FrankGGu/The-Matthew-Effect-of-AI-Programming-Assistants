#include <vector>
#include <numeric>

class Solution {
public:
    struct Node {
        long long sum_active;   // Sum of nums2[i] where nums1[i] == 1 in this range
        long long sum_inactive; // Sum of nums2[i] where nums1[i] == 0 in this range
        long long lazy_mul;     // Lazy multiplier for nums2 values in this range
    };

    std::vector<Node> tree;
    std::vector<int> nums1_arr; // To store the current state of nums1
    std::vector<long long> nums2_arr; // To store the current state of nums2 (as long long)
    int N;
    long long current_total_sum_active; // Global sum of nums2[i] where nums1[i] == 1

    void build(int node_idx, int L, int R) {
        tree[node_idx].lazy_mul = 1;
        if (L == R) {
            if (nums1_arr[L] == 1) {
                tree[node_idx].sum_active = nums2_arr[L];
                tree[node_idx].sum_inactive = 0;
            } else {
                tree[node_idx].sum_active = 0;
                tree[node_idx].sum_inactive = nums2_arr[L];
            }
        } else {
            int mid = L + (R - L) / 2;
            build(2 * node_idx, L, mid);
            build(2 * node_idx + 1, mid + 1, R);
            tree[node_idx].sum_active = tree[2 * node_idx].sum_active + tree[2 * node_idx + 1].sum_active;
            tree[node_idx].sum_inactive = tree[2 * node_idx].sum_inactive + tree[2 * node_idx + 1].sum_inactive;
        }
    }

    void push_down(int node_idx) {
        if (tree[node_idx].lazy_mul != 1) {
            // Apply lazy_mul to children's sums
            tree[2 * node_idx].sum_active *= tree[node_idx].lazy_mul;
            tree[2 * node_idx].sum_inactive *= tree[node_idx].lazy_mul;
            tree[2 * node_idx + 1].sum_active *= tree[node_idx].lazy_mul;
            tree[2 * node_idx + 1].sum_inactive *= tree[node_idx].lazy_mul;

            // Propagate lazy_mul to children
            tree[2 * node_idx].lazy_mul *= tree[node_idx].lazy_mul;
            tree[2 * node_idx + 1].lazy_mul *= tree[node_idx].lazy_mul;

            // Reset current node's lazy_mul
            tree[node_idx].lazy_mul = 1;
        }
    }

    // Type 0 query: Set nums1[index] to val
    void update_nums1_state(int node_idx, int L, int R, int target_idx, int new_val_nums1) {
        push_down(node_idx);

        if (L == R) { // Leaf node
            long long current_nums2_val = tree[node_idx].sum_active + tree[node_idx].sum_inactive;

            if (nums1_arr[target_idx] == 1 && new_val_nums1 == 0) {
                current_total_sum_active -= current_nums2_val;
                tree[node_idx].sum_active = 0;
                tree[node_idx].sum_inactive = current_nums2_val;
            } else if (nums1_arr[target_idx] == 0 && new_val_nums1 == 1) {
                current_total_sum_active += current_nums2_val;
                tree[node_idx].sum_active = current_nums2_val;
                tree[node_idx].sum_inactive = 0;
            }
            nums1_arr[target_idx] = new_val_nums1;
            return;
        }

        int mid = L + (R - L) / 2;
        if (target_idx <= mid) {
            update_nums1_state(2 * node_idx, L, mid, target_idx, new_val_nums1);
        } else {
            update_nums1_state(2 * node_idx + 1, mid + 1, R, target_idx, new_val_nums1);
        }

        tree[node_idx].sum_active = tree[2 * node_idx].sum_active + tree[2 * node_idx + 1].sum_active;
        tree[node_idx].sum_inactive = tree[2 * node_idx].sum_inactive + tree[2 * node_idx + 1].sum_inactive;
    }

    // Type 1 query: For i in [query_L, query_R], if nums1[i]==1, then nums2[i] *= 2
    void range_multiply(int node_idx, int L, int R, int query_L, int query_R) {
        push_down(node_idx);

        if (L > query_R || R < query_L) { // No overlap
            return;
        }
        if (query_L <= L && R <= query_R) { // Full overlap
            current_total_sum_active += tree[node_idx].sum_active; // Add the current sum_active (before doubling)
            tree[node_idx].sum_active *= 2;
            tree[node_idx].sum_inactive *= 2; 
            tree[node_idx].lazy_mul *= 2;
            return;
        }

        // Partial overlap
        int mid = L + (R - L) / 2;
        range_multiply(2 * node_idx, L, mid, query_L, query_R);
        range_multiply(2 * node_idx + 1, mid + 1, R, query_L, query_R);

        tree[node_idx].sum_active = tree[2 * node_idx].sum_active + tree[2 * node_idx + 1].sum_active;
        tree[node_idx].sum_inactive = tree[2 * node_idx].sum_inactive + tree[2 * node_idx + 1].sum_inactive;
    }

    std::vector<long long> handleQueries(std::vector<int>& nums1, std::vector<int>& nums2, std::vector<std::vector<int>>& queries) {
        N = nums1.size();
        tree.resize(4 * N);
        nums1_arr = nums1; 
        nums2_arr.assign(nums2.begin(), nums2.end()); 

        build(1, 0, N - 1);

        current_total_sum_active = 0;
        for (int i = 0; i < N; ++i) {
            if (nums1_arr[i] == 1) {
                current_total_sum_active += nums2_arr[i];
            }
        }

        std::vector<long long> results;
        for (const auto& query : queries) {
            int type = query[0];
            if (type == 0) {
                int index = query[1];
                int val = query[2];
                update_nums1_state(1, 0, N - 1, index, val);
            } else if (type == 1) {
                int l = query[1];
                int r = query[2];
                range_multiply(1, 0, N - 1, l, r);
            } else { // type == 2
                results.push_back(current_total_sum_active);
            }
        }
        return results;
    }
};