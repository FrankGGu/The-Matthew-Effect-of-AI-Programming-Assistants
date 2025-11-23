#include <vector>
#include <algorithm>
#include <limits>

using namespace std;

const long long INF = numeric_limits<long long>::max();

struct Node {
    long long min_val;
    long long lazy_add;
    long long lazy_min_update; // Represents min(val, X), where X is the value to min with
    int min_count; // For tracking number of subarrays
};

vector<Node> tree;
int N_seg; // Size of the segment tree's array

void combine(int node_idx) {
    if (tree[node_idx * 2].min_val < tree[node_idx * 2 + 1].min_val) {
        tree[node_idx].min_val = tree[node_idx * 2].min_val;
        tree[node_idx].min_count = tree[node_idx * 2].min_count;
    } else if (tree[node_idx * 2 + 1].min_val < tree[node_idx * 2].min_val) {
        tree[node_idx].min_val = tree[node_idx * 2 + 1].min_val;
        tree[node_idx].min_count = tree[node_idx * 2 + 1].min_count;
    } else {
        tree[node_idx].min_val = tree[node_idx * 2].min_val;
        tree[node_idx].min_count = min(tree[node_idx * 2].min_count, tree[node_idx * 2 + 1].min_count);
    }
}

void push(int node_idx, int L, int R) {
    if (tree[node_idx].lazy_add == 0 && tree[node_idx].lazy_min_update == INF) return;

    // Apply lazy_add first
    if (tree[node_idx].lazy_add != 0) {
        tree[node_idx].min_val += tree[node_idx].lazy_add; // Apply to current node's value

        if (L != R) { // If not a leaf, propagate to children
            tree[node_idx * 2].lazy_add += tree[node_idx].lazy_add;
            tree[node_idx * 2 + 1].lazy_add += tree[node_idx].lazy_add;

            // Adjust children's lazy_min_update by lazy_add
            if (tree[node_idx * 2].lazy_min_update != INF) tree[node_idx * 2].lazy_min_update += tree[node_idx].lazy_add;
            if (tree[node_idx * 2 + 1].lazy_min_update != INF) tree[node_idx * 2 + 1].lazy_min_update += tree[node_idx].lazy_add;
        }
        tree[node_idx].lazy_add = 0; // Reset current node's lazy_add
    }

    // Apply lazy_min_update
    if (tree[node_idx].lazy_min_update != INF) {
        // Apply to current node's value
        if (tree[node_idx].min_val > tree[node_idx].lazy_min_update) {
            tree[node_idx].min_val = tree[node_idx].lazy_min_update;
        }

        if (L != R) { // If not a leaf, propagate to children
            tree[node_idx * 2].lazy_min_update = min(tree[node_idx * 2].lazy_min_update, tree[node_idx].lazy_min_update);
            tree[node_idx * 2 + 1].lazy_min_update = min(tree[node_idx * 2 + 1].lazy_min_update, tree[node_idx].lazy_min_update);
        }
        tree[node_idx].lazy_min_update = INF; // Reset current node's lazy_min_update
    }
}

void build(int node_idx, int L, int R) {
    tree[node_idx] = {INF, 0, INF, 0}; // Initialize with INF cost
    if (L == R) {
        return;
    }
    int M = L + (R - L) / 2;
    build(node_idx * 2, L, M);
    build(node_idx * 2 + 1, M + 1, R);
}

void update_point(int node_idx, int L, int R, int pos, long long val, int count) {
    if (L == R) {
        if (val < tree[node_idx].min_val) {
            tree[node_idx].min_val = val;
            tree[node_idx].min_count = count;
        } else if (val == tree[node_idx].min_val) {
            tree[node_idx].min_count = min(tree[node_idx].min_count, count);
        }
        return;
    }
    push(node_idx, L, R); // Apply pending lazy updates before going down
    int M = L + (R - L) / 2;
    if (pos <= M) {
        update_point(node_idx * 2, L, M, pos, val, count);
    } else {
        update_point(node_idx * 2 + 1, M + 1, R, pos, val, count);
    }
    combine(node_idx); // Recalculate parent's min_val and min_count
}

void range_min_update(int node_idx, int L, int R, int query_L, int query_R, long long min_val_to_apply) {
    push(node_idx, L, R); // Apply pending lazy updates first
    if (L > query_R || R < query_L || tree[node_idx].min_val <= min_val_to_apply) return; // Pruning: if current min_val is already <= min_val_to_apply, no change needed

    if (query_L <= L && R <= query_R) { // Current node's range is fully within query range
        tree[node_idx].lazy_min_update = min(tree[node_idx].lazy_min_update, min_val_to_apply);
        push(node_idx, L, R); // Apply immediately to update min_val of current node
        return;
    }

    int M = L + (R - L) / 2;
    range_min_update(node_idx * 2, L, M, query_L, query_R, min_val_to_apply);
    range_min_update(node_idx * 2 + 1, M + 1, R, query_L, query_R, min_val_to_apply);
    combine(node_idx); // Recalculate parent's min_val and min_count
}

pair<long long, int> query(int node_idx, int L, int R, int query_L, int query_R) {
    if (L > query_R || R < query_L) return {INF, 0}; // Outside query range
    push(node_idx, L, R); // Apply pending lazy updates first
    if (query_L <= L && R <= query_R) { // Current node's range is fully within query range
        return {tree[node_idx].min_val, tree[node_idx].min_count};
    }
    int M = L + (R - L) / 2;
    pair<long long, int> left_res = query(node_idx * 2, L, M, query_L, query_R);
    pair<long long, int> right_res = query(node_idx * 2 + 1, M + 1, R, query_L, query_R);
    if (left_res.first < right_res.first) {
        return left_res;
    } else if (right_res.first < left_res.first) {
        return right_res;
    } else {
        return {left_res.first, min(left_res.second, right_res.second)};
    }
}

pair<long long, int> solve(int n, const vector<int>& nums, long long lambda) {
    vector<long long> dp(n);
    vector<int> count(n);

    N_seg = n;
    tree.assign(4 * N_seg, {INF, 0, INF, 0});
    build(1, 0, N_seg - 1);

    // Base case: dp[-1] = 0, count[-1] = 0 (conceptual)
    // For i=0: dp[0] = dp[-1] + nums[0] + min(nums[0...0]) + lambda = 0 + nums[0] + nums[0] + lambda = 2*nums[0] + lambda
    // count[0] = 1
    dp[0] = (long long)2 * nums[0] + lambda;
    count[0] = 1;

    // The segment tree at index `p` stores `dp[p] + nums[p+1] + min(nums[p+1...current_i])`.
    // Initially, when `p` is considered, `min(nums[p+1...p+1]) = nums[p+1]`.
    // So, `st[p]` stores `dp[p] + nums[p+1] + nums[p+1] = dp[p] + 2 * nums[p+1]`.
    // For `p=0`, this value is `dp[0] + 2 * nums[1]`.
    // This value is `dp[0]` if `n=1`.

    // For p=0, update segment tree with `dp[0] + 2*nums[1]` (if `n > 1`).
    // If `n=1`, `dp[0]` is the answer. No further splits.
    if (n > 1) {
        update_point(1, 0, N_seg - 1, 0, dp[0] + (long long)2 * nums[1], count[0]);
    }

    for (int i = 1; i < n; ++i) {
        // For `p` in `[0, i-1]`, `min(nums[p+1...i-1])` becomes `min(min(nums[p+1...i-1]), nums[i])`.
        // This is handled by `range_min_update(0, i-1, nums[i])`.
        // The `range_min_update` applies `min(val, nums[i])` to the `min_suffix_val` part of the stored `dp[p] + nums[p+1] + min_suffix_val`.
        range_min_update(1, 0, N_seg - 1, 0, i - 1, (long long)nums[i]);

        // Query for dp[i]
        // This queries `min_{p \in [0, i-1]} (dp[p] + nums[p+1] + min(nums[p+1...i]))`.
        pair<long long, int> res = query(1, 0, N_seg - 1, 0, i - 1);

        dp[i] = res.first + lambda;
        count[i] = res.second + 1;

        // Store dp[i] for future calculations (as a `p` for `i+1`)
        // The value to store is `dp[i] + 2 * nums[i+1]` (if `i+1 < n`).
        if (i < n - 1) {
            update_point(1, 0, N_seg - 1, i, dp[i] + (long long)2 * nums[i+1], count[i]);
        }
    }
    return {dp[n-1], count[n-1]};
}

class Solution {
public:
    long long minimumCost(vector<int>& nums, int k) {
        int n = nums.size();
        if (n == 0) return 0;
        if (k == 1) { // Special case for k=1, no splits needed
            long long min_val = nums[0];
            for (int x : nums) {
                min_val = min(min_val, (long long)x);
            }
            return (long long)nums[0] + min_val;
        }

        // Binary search for lambda (penalty per subarray)
        // lambda range: from min_val_in_nums * 2 * n to max_val_in_nums * 2 * n (approx)
        // Max possible cost for a single subarray is 2 * 10^9.
        // So lambda can be in range [-2*10^9, 2*10^9].
        // Max total cost is N * 2 * Max_num = 10^5 * 2 * 10^9 = 2 * 10^14.
        // Min total cost is N * 2 * Min_num = 10^5 * 1 * 0 = 0 (if nums can be 0).
        // The range for lambda should cover the possible costs of `nums[p+1] + min(nums[p+1...i])`.
        // This value can be up to 2 * 10^9.
        // So lambda can be from -2 * 10^9 to 2 * 10^9.
        long long low = -2000000000LL; 
        long long high = 2000000000LL; 

        long long final_cost_with_penalty = 0;
        int final_count = 0;
        long long final_lambda = 0;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            pair<long long, int> res = solve(n, nums, mid);

            if (res.second >= k) { // Too many or exactly k subarrays, try to increase lambda to reduce count
                final_cost_with_penalty = res.first;
                final_count = res.second;
                final_lambda = mid;
                low = mid + 1;
            } else { // Too few subarrays, need to decrease lambda to increase count
                high = mid - 1;
            }
        }

        // The `solve` function returns `actual_cost + count * lambda`.
        // We want `actual_cost` for `k` subarrays.
        // The binary search finds the largest `lambda` (`final_lambda`) such that `count >= k`.
        // If `final_count > k`, it means we obtained `final_count` subarrays with `final_lambda`.
        // We need exactly `k` subarrays. To reduce `final_count` to `k`, we effectively "remove" `final_count - k` splits.
        // Each removed split saves `lambda` penalty.
        // So, the actual cost for `k` subarrays is `(final_cost_with_penalty - final_count * final_lambda) + k * final_lambda`.
        // This simplifies to `final_cost_with_penalty - (final_count - k) * final_lambda`.

        return final_cost_with_penalty - (long long)k * final_lambda;
    }
};