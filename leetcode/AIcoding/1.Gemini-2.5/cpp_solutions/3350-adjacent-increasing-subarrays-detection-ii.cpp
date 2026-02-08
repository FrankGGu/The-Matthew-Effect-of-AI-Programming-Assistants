#include <vector>
#include <algorithm>
#include <climits> // For INT_MIN
#include <utility>   // For std::pair

class Solution {
public:
    struct SegmentTreeNode {
        std::vector<std::pair<int, int>> sorted_pairs; // stores {L_j, R_j}
        std::vector<int> max_R_prefix;                 // stores max R_j for prefix of sorted_pairs
    };

    std::vector<int> L_values; // L_j = j - inc_prefix[j] + 1
    std::vector<int> R_values; // R_j = j + inc_suffix[j+1] - (k-1)
    std::vector<SegmentTreeNode> tree;
    int N_val; // size of nums
    int K_val; // window size k

    void build(int node_idx, int seg_L, int seg_R) {
        if (seg_L == seg_R) {
            tree[node_idx].sorted_pairs.push_back({L_values[seg_L], R_values[seg_L]});
            tree[node_idx].max_R_prefix.push_back(R_values[seg_L]);
            return;
        }

        int mid = seg_L + (seg_R - seg_L) / 2;
        build(2 * node_idx, seg_L, mid);
        build(2 * node_idx + 1, mid + 1, seg_R);

        // Merge sorted_pairs from children
        auto& left_pairs = tree[2 * node_idx].sorted_pairs;
        auto& right_pairs = tree[2 * node_idx + 1].sorted_pairs;
        tree[node_idx].sorted_pairs.resize(left_pairs.size() + right_pairs.size());
        std::merge(left_pairs.begin(), left_pairs.end(),
                   right_pairs.begin(), right_pairs.end(),
                   tree[node_idx].sorted_pairs.begin());

        // Compute max_R_prefix for current node
        tree[node_idx].max_R_prefix.resize(tree[node_idx].sorted_pairs.size());
        if (!tree[node_idx].sorted_pairs.empty()) {
            tree[node_idx].max_R_prefix[0] = tree[node_idx].sorted_pairs[0].second;
            for (size_t i = 1; i < tree[node_idx].sorted_pairs.size(); ++i) {
                tree[node_idx].max_R_prefix[i] = std::max(tree[node_idx].max_R_prefix[i-1], 
                                                           tree[node_idx].sorted_pairs[i].second);
            }
        }
    }

    int query(int node_idx, int seg_L, int seg_R, int query_L, int query_R, int target_i) {
        if (seg_L > query_R || seg_R < query_L) { // No overlap
            return INT_MIN;
        }
        if (query_L <= seg_L && seg_R <= query_R) { // Full overlap
            auto& current_pairs = tree[node_idx].sorted_pairs;
            // Find first {L_j, R_j} where L_j > target_i.
            // All elements before this iterator satisfy L_j <= target_i.
            auto it = std::upper_bound(current_pairs.begin(), current_pairs.end(), 
                                       std::make_pair(target_i, INT_MAX)); 

            if (it == current_pairs.begin()) { // No L_j <= target_i in this node's range
                return INT_MIN;
            }
            // The elements from begin() up to (it-1) satisfy L_j <= target_i.
            // We need the maximum R_j among these. This is stored in max_R_prefix.
            int prefix_idx = std::distance(current_pairs.begin(), it) - 1;
            return tree[node_idx].max_R_prefix[prefix_idx];
        }

        // Partial overlap
        int mid = seg_L + (seg_R - seg_L) / 2;
        int res1 = query(2 * node_idx, seg_L, mid, query_L, query_R, target_i);
        int res2 = query(2 * node_idx + 1, mid + 1, seg_R, query_L, query_R, target_i);
        return std::max(res1, res2);
    }

    std::vector<bool> canBeIncreasing(std::vector<int>& nums, int k) {
        N_val = nums.size();
        K_val = k;

        if (K_val == 1) { // A single element window cannot be split into two adjacent non-empty subarrays
            return std::vector<bool>(N_val, false);
        }
        if (N_val < K_val) { // Not enough elements for any window of size k
            return {};
        }

        std::vector<int> inc_prefix(N_val);
        inc_prefix[0] = 1;
        for (int i = 1; i < N_val; ++i) {
            if (nums[i] > nums[i-1]) {
                inc_prefix[i] = inc_prefix[i-1] + 1;
            } else {
                inc_prefix[i] = 1;
            }
        }

        std::vector<int> inc_suffix(N_val);
        inc_suffix[N_val-1] = 1;
        for (int i = N_val - 2; i >= 0; --i) {
            if (nums[i] < nums[i+1]) {
                inc_suffix[i] = inc_suffix[i+1] + 1;
            } else {
                inc_suffix[i] = 1;
            }
        }

        // Calculate L_values and R_values for j from 0 to N_val-2
        // j is the split point, meaning the left subarray ends at j and the right starts at j+1.
        // Thus, j can range from 0 to N_val-2.
        // The right part starts at j+1, so inc_suffix[j+1] is used.
        // j+1 must be a valid index, so j+1 <= N_val-1, meaning j <= N_val-2.
        int num_j_values = N_val - 1; // Number of possible split points in the entire array

        // If N_val < 2, there are no possible split points.
        // This is implicitly handled by N_val < K_val or K_val == 1 checks if N_val is 0 or 1.
        // If N_val >= 2, then num_j_values >= 1.
        if (num_j_values <= 0) { 
            return std::vector<bool>(N_val - K_val + 1, false);
        }

        L_values.resize(num_j_values);
        R_values.resize(num_j_values);

        for (int j = 0; j < num_j_values; ++j) {
            // Condition for left part (nums[i...j]) to be increasing:
            // The increasing sequence ending at 'j' must start at or before 'i'.
            // The actual start index of the increasing sequence ending at 'j' is (j - inc_prefix[j] + 1).
            // So, we need (j - inc_prefix[j] + 1) <= i.
            L_values[j] = j - inc_prefix[j] + 1;

            // Condition for right part (nums[j+1...i+K_val-1]) to be increasing:
            // The increasing sequence starting at 'j+1' must end at or after 'i+K_val-1'.
            // The actual end index of the increasing sequence starting at 'j+1' is (j+1 + inc_suffix[j+1] - 1) = (j + inc_suffix[j+1]).
            // So, we need (j + inc_suffix[j+1]) >= (i + K_val - 1).
            // Rearranging for 'i': i <= (j + inc_suffix[j+1] - (K_val - 1)).
            R_values[j] = j + inc_suffix[j+1] - (K_val - 1);
        }

        // Build segment tree over the possible split point indices [0, num_j_values-1]
        tree.resize(4 * num_j_values);
        build(1, 0, num_j_values - 1);

        std::vector<bool> result(N_val - K_val + 1);
        for (int i = 0; i <= N_val - K_val; ++i) {
            // For the current window [i, i+K_val-1], the split point 'j' can range from 'i' to 'i+K_val-2'.
            // This range defines the query range for the segment tree.
            int query_L = i;
            int query_R = i + K_val - 2;

            if (query_L > query_R) { // No possible split point within the window (e.g., K_val=1, already handled)
                result[i] = false;
                continue;
            }

            // Query the segment tree for the maximum R_j in the range [query_L, query_R]
            // such that L_j <= i.
            int max_R_for_valid_L = query(1, 0, num_j_values - 1, query_L, query_R, i);

            // If such a j exists, then max_R_for_valid_L will be >= i.
            result[i] = (max_R_for_valid_L >= i);
        }

        return result;
    }
};